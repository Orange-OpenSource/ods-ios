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

// ===============================
// MARK: - MoreApps List
// ===============================

/// Business object to gather both sections and apps ready to use for the _ModeApps module_
struct MoreAppsList {
    /// All available sections of apps
    let sections: [MoreAppsListSection]
    /// All available apps without associated sections
    let apps: [MoreAppDetails]
}

extension MoreAppsList {

    /// Returns a fresh new object without any sections anymore but with all apps of all sections add in the_apps_.
    /// Order of apps is based on order of previous sections.
    /// - Returns MoreAppsList: Flattened version without changing `self`
    func flattened() -> MoreAppsList {
        var flattenedApps = apps
        sections.forEach {
            flattenedApps.append(contentsOf: $0.apps)
        }
        return MoreAppsList(sections: [], apps: flattenedApps)
    }
}

// ==================================
// MARK: - MoreApps List Section
// ==================================

/// Business object to gather a group of apps behind a description ready to use for the _MoreApps module_
struct MoreAppsListSection {
    /// Some description for a section, e.g. "customer" or "business"
    let description: String
    /// All the apps for this section
    let apps: [MoreAppDetails]
}

extension MoreAppsListSection: Hashable {}

// =================================
// MARK: - MoreApps Details
// =================================

/// Business object modelizing details of an app ready to use for the _MoreApps module_
struct MoreAppDetails {
    /// Commercial title of the app
    let title: String
    /// URL to use to load the icon of the app
    let iconURL: URL?
    /// Some commercial description for the app
    let description: String?
    /// Link to use to redirect the user to the app through the App Store
    let storeURL: URL?
}

extension MoreAppDetails: Hashable {}
