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

import SwiftUI

/// Configuration to add in list the item that opens the apps recirculation view.
///
/// By default, this item is placed between legal information item and rate the app item. That can be changed with new priority set in the configuration.
public struct ODSRecirculationItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    public private(set) var title: String
    public private(set) var icon: Image
    public private(set) var target: ODSAboutListItemTarget
    public private(set) var priority: ODSAboutListItemPriority


    // =================
    // MARK: Initializer
    // =================

    /// Initializes the configuration.
    ///
    /// - Parameters:
    ///    - source: The source to use to get data
    ///    - flattenApps: True if all apps must be palced in one list without categories, false (default) to keep categories
    ///    - cacheAppsIcons: True (default) to use app cache to save locally the apps stores icons, false otherwise
    ///    - enableHaptics: True (default) to enable vibrations with the module, false to disable
    ///    - priority: Priority to adjust the position of the item in the list.
    public init(dataSource: ODSRecirculationDataSource,
                flattenApps: Bool = false,
                cacheAppsIcons: Bool = true,
                enableHaptics: Bool = true,
                priority: ODSAboutListItemPriority = .moreApps)
    {
        title = "modules.about.recirculation.title".🌐
        icon = Image("ic_mobile_apps", bundle: Bundle.ods)
        let destination = ODSRecirculation(
            dataSource: dataSource,
            flattenApps: flattenApps,
            cacheAppsIcons: cacheAppsIcons,
            enableHaptics: enableHaptics)

        target = .destination(AnyView(destination))
        self.priority = priority
    }
}
