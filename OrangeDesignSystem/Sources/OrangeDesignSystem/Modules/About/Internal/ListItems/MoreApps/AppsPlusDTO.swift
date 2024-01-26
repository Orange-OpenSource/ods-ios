//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import Foundation

// ==========================
// MARK: - AppsPlus Data Type
// ==========================

/// Data transfer object helping to know the type of data returned by the _AppsPlus_ backend
enum AppsPlusDataTypeDTO: String, Decodable {
    case list
    case section
    case app
}

// ==================
// MARK: AppsPlus DTO
// ==================

/// Data transfer object for root object sent by _AppsPlus_ backend
struct AppsPlusDTO: Decodable {
    let items: [AppsPlusListDTO]

    enum CodingKeys: String, CodingKey {
        case items
    }
}

// =========================
// MARK: AppsPlus Bundle DTO
// =========================

/// Data transfer object gathering a group of apps or sections
struct AppsPlusListDTO: Decodable {
    let type: AppsPlusDataTypeDTO
    let children: [Decodable]

    private enum CodingKeys: String, CodingKey {
        case type
        case children
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(AppsPlusDataTypeDTO.self, forKey: .type)

        var childrenContainer = try container.nestedUnkeyedContainer(forKey: .children)
        var decodedChildren: [Decodable] = []

        while !childrenContainer.isAtEnd {
            if let appInfo = try? childrenContainer.decode(AppsPlusAppDetailsDTO.self) {
                decodedChildren.append(appInfo)
            } else if let sectionInfo = try? childrenContainer.decode(AppsPlusSectionDTO.self) {
                decodedChildren.append(sectionInfo)
            }
        }

        children = decodedChildren
    }
}

extension AppsPlusListDTO {

    var apps: [AppsPlusAppDetailsDTO] {
        children.compactMap { $0 as? AppsPlusAppDetailsDTO }
    }

    var sections: [AppsPlusSectionDTO] {
        children.compactMap { $0 as? AppsPlusSectionDTO }
    }
}

// ==========================
// MARK: AppsPlus Section DTO
// ==========================

/// Data transfer object to gather a group of apps
struct AppsPlusSectionDTO: Decodable {
    let type: AppsPlusDataTypeDTO
    let description: String
    let apps: [AppsPlusAppDetailsDTO]

    private enum CodingKeys: String, CodingKey {
        case type
        case description
        case apps = "children"
    }
}

// ==============================
// MARK: AppsPlus App Details DTO
// ==============================

/// Data transfer object for an app available in the store, picked from the AppsPlus backend.
struct AppsPlusAppDetailsDTO: Decodable {
    let type: AppsPlusDataTypeDTO
    let title: String
    let iconURL: String
    let description: String
    let storeLink: String

    private enum CodingKeys: String, CodingKey {
        case type
        case title
        case iconURL = "iconUrl"
        case description
        case storeLink = "link"
    }
}

// ==================================
// MARK: - More Apps Apps Plus Mapper
// ===================================

/// Helps to convert _data transfert objects_ picked from _AppsPlus_ backend to _business objects_ for the ODS modules.
struct AppsPlusMoreAppsMapper {

    func appsSections(from appsList: AppsPlusListDTO) -> [MoreAppsSection] {
        appsList.sections.map { appsSection(from: $0) }
    }

    func appsDetails(from appsList: AppsPlusListDTO) -> [MoreAppsAppDetails] {
        appsList.apps.map { appDetails(from: $0) }
    }

    func appsSection(from section: AppsPlusSectionDTO) -> MoreAppsSection {
        MoreAppsSection(description: section.description,
                        apps: section.apps.map { appDetails(from: $0) })
    }

    func appDetails(from details: AppsPlusAppDetailsDTO) -> MoreAppsAppDetails {
        MoreAppsAppDetails(title: details.title,
                           iconURL: URL(string: details.iconURL),
                           description: details.description.isEmpty ? nil : details.description,
                           storeURL: URL(string: details.storeLink))
    }
}

// ============================
// MARK: - Apps Plus Repository
// ============================

/// Requests the Apps Plus backend to get list of availables apps, usging also HTTP cache and local file cache
struct AppsPlusRepository: MoreAppsRepositoryProtocol {

    private let feedURL: URL
    private let urlSessionConfiguration: URLSessionConfiguration
    private let cache: URLCache

    // Store in user defaults because the ETag can vary times to times
    @UserDefaultsWrapper(key: "ODS_MoreApps_AppsPlus_lastResourceEtag", defaultValue: nil)
    private static var lastResourceEtag: String? // Static here to prevent to make calling methods "mutating"

    init(feedURL: URL, urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.feedURL = feedURL
        self.urlSessionConfiguration = urlSessionConfiguration
        cache = .shared
    }

    /// Using some `URL` and  `URLSessionConfiguration` gets  `AppsPlusDTO` object from the _Apps Plus_ backend, parse it
    /// and returns a `MoreAppsList` with list of apps and sections of apps inside.
    /// The data got from the service is also saved in cache (local file) so as to be available if the device is offline or if some error occured.
    /// - Returns: The business object containing all apps and sections of apps
    /// - Throws: `Error.badConfigurationPrerequisites` if not possible to build the URL for the _Apps Plus_ backend.
    func availableAppsList() async throws -> MoreAppsList {

        var request = URLRequest(url: feedURL)
        if let lastResourceEtag = Self.lastResourceEtag {
            request.addValue(lastResourceEtag, forHTTPHeaderField: "If-None-Match")
        }

        let urlSession = prepareSession()

        var appsPlusRawData: Data, response: URLResponse, httpResponse: HTTPURLResponse?
        do {
            (appsPlusRawData, response) = try await urlSession.data(for: request)
            httpResponse = response as? HTTPURLResponse
            // If current ETag is different than the last known Etag, local cache must be updated (200), otherwise should be hidden 304
            if let httpResponse = httpResponse, let etag = httpResponse.allHeaderFields["Etag"] as? String, etag != Self.lastResourceEtag {
                Self.lastResourceEtag = etag
            }
        } catch { // Timeout and connection issues managed here
            ODSLogger.error("Failed to send request to AppsPlus service: '\(error.localizedDescription)'")
            if let cachedMoreAppsList = cachedMoreAppsList(for: request) {
                ODSLogger.debug("But AppsPlus data in cache available, use them")
                return cachedMoreAppsList
            }
            throw MoreAppsErrors.sessionError
        }

        if let httpResponse = httpResponse {
            let reponseStatusCode = httpResponse.statusCode
            ODSLogger.debug("HTTP status code from AppsPlus backend: '\(reponseStatusCode)'")
            // If server error use cache (not sure it's relevant if client error like 401 Unauthorized, 403 Forbidden or 407 Proxy Authentication Required)
            if reponseStatusCode >= 500 {
                ODSLogger.error("Server error: '\(httpResponse.statusCode)'")
                if let cachedMoreAppsList = cachedMoreAppsList(for: request) {
                    ODSLogger.debug("But AppsPlus data in cache available, use them")
                    return cachedMoreAppsList
                }
            }
        }

        // Decode JSON payload
        var appsPlusAppsList: AppsPlusListDTO
        do {
            // Only one object sent by AppsPlus backend
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: appsPlusRawData).items[0]
        } catch {
            ODSLogger.error("Failed to decode AppsPlus service data: '\(error.localizedDescription)'")
            if let cachedMoreAppsList = cachedMoreAppsList(for: request) {
                ODSLogger.debug("But AppsPlus data in cache available, use them")
                return cachedMoreAppsList
            }
            throw MoreAppsErrors.jsonDecodingFailure
        }

        let mapper = AppsPlusMoreAppsMapper()
        let odsApps = mapper.appsDetails(from: appsPlusAppsList)
        let odsAppsSections = mapper.appsSections(from: appsPlusAppsList)
        let moreAppsList = MoreAppsList(sections: odsAppsSections, apps: odsApps)
        ODSLogger.debug("Got data from AppsPlus service with \(odsApps.count) apps and \(odsAppsSections.count) sections")
        return moreAppsList
    }

    // ============
    // MARK: Helper
    // ============

    private func prepareSession() -> URLSession {
        /*
         Be cautious here because HTTP cache with ETag is used.
         So even if the backend returns a 304 status code, the `URLSession` sees it at 200 status code.
         The HTTP stack cache will be used transparently with this current configuration.
         If the cache policy for URLRequest or URLSession is changed in this implementation, the 304 status code must be managed.
         See https://jonathanblog2000.blogspot.com/2017/07/ios-uiwebview-nsurlsession-cache.html
         */
        let urlSessionConfiguration = urlSessionConfiguration
        urlSessionConfiguration.urlCache = cache
        urlSessionConfiguration.requestCachePolicy = .useProtocolCachePolicy
        urlSessionConfiguration.timeoutIntervalForResource = 10 // 10 seconds are enough
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        urlSession.sessionDescription = "ODS - MoreApps - AppsPlus Session" // Mainly for Instruments debuging
        return urlSession
    }
    
    /// Returns from the cache directory the content previously picked from AppsPlus backend, or nil if error occured
    /// - Returns MoreAppsList?
    private func cachedMoreAppsList(for request: URLRequest) -> MoreAppsList? {
        guard let cachedResponse = cache.cachedResponse(for: request) else {
            ODSLogger.debug("No cache is available for this request")
            return nil
        }

        var appsPlusAppsList: AppsPlusListDTO
        do {
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: cachedResponse.data).items[0]
        } catch {
            ODSLogger.error("(ノಠ益ಠ)ノ彡┻━┻ Failed to decode AppsPlus JSON data in cache: '\(error.localizedDescription)'")
            return nil
        }

        let mapper = AppsPlusMoreAppsMapper()
        let odsApps = mapper.appsDetails(from: appsPlusAppsList)
        let odsAppsSections = mapper.appsSections(from: appsPlusAppsList)
        let moreAppsList = MoreAppsList(sections: odsAppsSections, apps: odsApps)
        return moreAppsList
    }
}

// ==================================
// MARK: - Local Apps Plus Repository
// ==================================

/// Parses local JSON data from file, supposing to be Apps Plus data
struct LocalAppsPlusRepository: MoreAppsRepositoryProtocol {

    private let feedURL: URL
    var localCacheLocation: URL?

    init(feedURL: URL) {
        self.feedURL = feedURL
        localCacheLocation = nil
    }

    func availableAppsList() async throws -> MoreAppsList {
        var appsPlusAppsList: AppsPlusListDTO
        do {
            let rawData = try Data(contentsOf: feedURL)
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: rawData).items[0]
        } catch {
            ODSLogger.error("(ノಠ益ಠ)ノ彡┻━┻ Failed to decode local AppsPlus file: '\(error.localizedDescription)'")
            throw MoreAppsErrors.jsonDecodingFailure
        }

        let mapper = AppsPlusMoreAppsMapper()
        let odsApps = mapper.appsDetails(from: appsPlusAppsList)
        let odsAppsSections = mapper.appsSections(from: appsPlusAppsList)
        let moreAppsList = MoreAppsList(sections: odsAppsSections, apps: odsApps)
        ODSLogger.debug("Got data from AppsPlus local file with \(odsApps.count) apps and \(odsAppsSections.count) sections")
        return moreAppsList
    }
}
