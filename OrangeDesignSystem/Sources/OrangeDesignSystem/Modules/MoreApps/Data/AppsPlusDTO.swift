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
