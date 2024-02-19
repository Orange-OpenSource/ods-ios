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

// ===============================
// MARK: - Recirculation Apps List
// ===============================

/// Business object to gather both sections and apps ready to use for the _Recirculation module_
struct RecirculationAppsList {
    /// All available sections of apps
    let sections: [RecirculationAppsListSection]
    /// All available apps without associated sections
    let apps: [RecirculationAppDetails]
}

extension RecirculationAppsList {

    /// Returns a fresh new object without any sections anymore but with all apps of all sections add in the_apps_.
    /// Order of apps is based on order of previous sections.
    /// - Returns MoreAppsList: Flattened version without changing `self`
    func flattened() -> RecirculationAppsList {
        var flattenedApps = apps
        sections.forEach {
            flattenedApps.append(contentsOf: $0.apps)
        }
        return RecirculationAppsList(sections: [], apps: flattenedApps)
    }
}

// ==================================
// MARK: - Recirculation Apps Section
// ==================================

/// Business object to gather a group of apps behind a description ready to use for the _Recirculation module_
struct RecirculationAppsListSection {
    /// Some description for a section, e.g. "customer" or "business"
    let description: String
    /// All the apps for this section
    let apps: [RecirculationAppDetails]
}

extension RecirculationAppsListSection: Hashable {}

// =================================
// MARK: - Recirculation App Details
// =================================

/// Business object modelizing details of an app ready to use for the _Recirculation module_
struct RecirculationAppDetails {
    /// Commercial title of the app
    let title: String
    /// URL to use to load the icon of the app
    let iconURL: URL?
    /// Some commercial description for the app
    let description: String?
    /// Link to use to redirect the user to the app through the App Store
    let storeURL: URL?
}

extension RecirculationAppDetails: Hashable {}
