//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
// 
// This software is distributed under the MIT licence,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
// 
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System 
//

import Foundation

/// Helps to convert _data transfert objects_ picked from _AppsPlus_ backend to _business objects_ for the ODS modules.
struct AppsPlusToMoreAppsMapper {

    func appsSections(from appsList: AppsPlusListDTO) -> [MoreAppsAppsListSection] {
        appsList.sections.map { appsSection(from: $0) }
    }

    func appsDetails(from appsList: AppsPlusListDTO) -> [MoreAppsAppDetails] {
        appsList.apps.map { appDetails(from: $0) }
    }

    func appsSection(from section: AppsPlusSectionDTO) -> MoreAppsAppsListSection {
        MoreAppsAppsListSection(description: section.description,
                        apps: section.apps.map { appDetails(from: $0) })
    }

    func appDetails(from details: AppsPlusAppDetailsDTO) -> MoreAppsAppDetails {
        MoreAppsAppDetails(title: details.title,
                           iconURL: URL(string: details.iconURL),
                           description: details.description.isEmpty ? nil : details.description,
                           storeURL: URL(string: details.storeLink))
    }
}
