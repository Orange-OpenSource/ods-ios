//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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

// ====================
// MARK: - AppsPlus DTO
// ====================

/// Data transfer object for root object sent by _AppsPlus_ backend
struct AppsPlusDTO: Decodable {
    let items: [AppsPlusListDTO]

    enum CodingKeys: String, CodingKey {
        case items
    }
}

// ===========================
// MARK: - AppsPlus Bundle DTO
// ===========================

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

// swiftlint:disable force_cast
extension AppsPlusListDTO {

    var apps: [AppsPlusAppDetailsDTO] {
        children.filter { $0 is AppsPlusAppDetailsDTO }.map { $0 as! AppsPlusAppDetailsDTO }
    }

    var sections: [AppsPlusSectionDTO] {
        children.filter { $0 is AppsPlusSectionDTO }.map { $0 as! AppsPlusSectionDTO }
    }
}

// swiftlint:enable force_cast

// ============================
// MARK: - AppsPlus Section DTO
// ============================

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

// ================================
// MARK: - AppsPlus App Details DTO
// ================================

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

// ===========================
// MARK: - AppsPlus Repository
// ===========================

struct AppsPlusRepository: MoreAppsRepositoryProtocol {

    /// Using the given URL gets some `AppsPlusDTO` object from the _Apps Plus_ backend, parse it
    /// and returns a `MoreAppsList` with list of apps and sections of apps inside.
    /// The data got from the service is also saved in cache so as to be available if the device is offline or if some error occured.
    /// - Parameter feedURL: The URL ready to be used to to get data
    /// - Returns: The business object containing all apps and sections of apps
    /// - Throws: `Error.badConfigurationPrerequisites` if not possible to build the URL for the _Apps Plus_ backend.
    func availableAppsList(at feedURL: URL) async throws -> MoreAppsList {
        let sessionConfiguration = URLSessionConfiguration.default
        // No cache implemented in Apps Plus backend
        sessionConfiguration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
        let session = URLSession(configuration: sessionConfiguration)

        var appsPlusRawData: Data, response: URLResponse
        do {
            (appsPlusRawData, response) = try await session.data(from: feedURL)
        } catch {
            ODSLogger.error("Failed to send request to AppsPlus service: '\(error.localizedDescription)'")
            if let cachedMoreAppsList = cachedMoreAppsList() {
                ODSLogger.debug("But AppsPlus data in cache available, use them")
                return cachedMoreAppsList
            }
            throw MoreAppsErrors.sessionError
        }

        // If server error use cache (not sure it's relevant if client error like 401, 403 or 407)
        if let response = response as? HTTPURLResponse, response.statusCode >= 500 {
            ODSLogger.error("Server error: '\(response.statusCode)'")
            if let cachedMoreAppsList = cachedMoreAppsList() {
                ODSLogger.debug("But AppsPlus data in cache available, use them")
                return cachedMoreAppsList
            }
        }

        // Decode JSON payload
        var appsPlusAppsList: AppsPlusListDTO
        do {
            // Only one object sent by AppsPlus backend
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: appsPlusRawData).items[0]
        } catch {
            ODSLogger.error("Failed to decode AppsPlus service data: '\(error.localizedDescription)'")
            if let cachedMoreAppsList = cachedMoreAppsList() {
                ODSLogger.debug("But AppsPlus data in cache available, use them")
                return cachedMoreAppsList
            }
            throw MoreAppsErrors.jsonDecodingFailure
        }
        cache(data: appsPlusRawData)

        ODSLogger.debug("Got data from AppsPlus service")
        let mapper = AppsPlusMoreAppsMapper()
        let odsApps = mapper.appsDetails(from: appsPlusAppsList)
        let odsAppsSections = mapper.appsSections(from: appsPlusAppsList)
        let moreAppsList = MoreAppsList(sections: odsAppsSections, apps: odsApps)
        return moreAppsList
    }

    /// Saves in a cache file the given `Data` picked from AppsPlus backend
    /// - Parameter payload: Data retrieved from `URLSession`
    private func cache(data payload: Data) {
        // Forge file URL
        var fileURL: URL
        do {
            fileURL = try FileManager.default
                .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("AppsPlus.json")
        } catch {
            ODSLogger.error("Failed to get AppsPlus file in caches directory: '\(error.localizedDescription)'")
            return
        }

        // Remove if exists and create new one
        do {
            if FileManager.default.fileExists(atPath: fileURL.path) {
                try FileManager.default.removeItem(atPath: fileURL.path)
                ODSLogger.debug("The AppsPlus JSON file already exists, removed it")
            }
            try payload.write(to: fileURL, options: .atomic)
            ODSLogger.debug("JSON file for AppsPlus has been saved at '\(fileURL)'")
        } catch {
            ODSLogger.error("(ノಥ,_｣ಥ)ノ彡┻━┻ Impossible to save on device the AppsPlus JSON file: '\(error.localizedDescription)'")
        }
    }

    /// Returns from the cache directory the content previously picked from AppsPlus backend, or nil if error occured
    /// - Returns MoreAppsList.
    private func cachedMoreAppsList() -> MoreAppsList? {
        // Forge file URL
        var fileURL: URL
        do {
            fileURL = try FileManager.default
                .url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("AppsPlus.json")
        } catch {
            ODSLogger.error("Failed to get AppsPlus file in caches directory: '\(error.localizedDescription)'")
            return nil
        }

        // Read file
        var cachedRawData: Data
        do {
            cachedRawData = try Data(contentsOf: fileURL)
        } catch {
            ODSLogger.error("Failed to read AppsPlus file content in cache: '\(error.localizedDescription)'")
            return nil
        }

        // Decode file
        var appsPlusAppsList: AppsPlusListDTO
        do {
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: cachedRawData).items[0]
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
