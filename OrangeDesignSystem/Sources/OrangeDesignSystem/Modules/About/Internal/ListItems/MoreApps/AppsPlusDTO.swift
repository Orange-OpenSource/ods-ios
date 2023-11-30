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

    enum Error: Swift.Error {
        /// Prerequisites are not fullfilled to request the _Apps Plus_ service
        case badConfigurationPrerequisites
        /// Some issue occured with session or network requests
        case sessionError
        /// JSON decoding error
        case jsonDecodingFailure
    }

    /// Forges the URL to use to reach the _Apps Plus_ service, then gets some `AppsPlusDTO` object,
    /// parse it and returns a `MoreAppsList` with list of apps and sections of apps inside.
    /// - Returns: The business object containing all apps and sections of apps
    /// - Throws: `Error.badConfigurationPrerequisites` if not possible to build the URL for the _Apps Plus_ backend.
    func availableAppsList() async throws -> MoreAppsList {
        guard let serviceURL = forgeURL() else {
            ODSLogger.error("Failed to forge the Apps Plus service URL")
            throw Error.badConfigurationPrerequisites
        }

        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData // No cache implemented in Apps Plus backend
        let session = URLSession(configuration: sessionConfiguration)
        var data: Data
        do {
            (data, _) = try await session.data(from: serviceURL)
        } catch {
            ODSLogger.error("Failed to send request to Apps Plus service")
            throw Error.sessionError
        }

        var appsPlusAppsList: AppsPlusListDTO
        do {
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: data).items[0] // Only one object sent by AppsPlus backend
        } catch {
            ODSLogger.error("Failed to decode Apps Plus service data")
            throw Error.jsonDecodingFailure
        }

        let mapper = AppsPlusMoreAppsMapper()
        let odsApps = mapper.appsDetails(from: appsPlusAppsList)
        let odsAppsSections = mapper.appsSections(from: appsPlusAppsList)
        return MoreAppsList(sections: odsAppsSections, apps: odsApps)
    }

    /// Reads from main `Bundle``infoDicationary` the URL of the _Apps Plus_ backend to reach (at **APPS_PLUS_URL**)
    /// or use instead the given `String` if defined.
    /// Then adds the current locale as a _lang_ argument, and tries to forge the final `URL`.
    /// - Returns `URL?`: The final `URL` ready to use, or `nil` if the **APPS_PLUS_URL** was not found.
    private func forgeURL() -> URL? {
        guard let appsPlusURL = Bundle.main.infoDictionary?["APPS_PLUS_URL"] else {
            ODSLogger.warning("No Apps Plus URL found in app settings")
            return nil
        }
        let currentLocale = Bundle.main.preferredLocalizations[0]
        let requestURL = "\(appsPlusURL)&lang=\(currentLocale)"
        return URL(string: requestURL)
    }
}
