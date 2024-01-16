//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

/// Configuration to add in list the item that opens the apps recirculation view.
///
/// By default, this item is placed between legal information item and rate the app item. That can be changed with new priority set in the configuration.
public struct ODSMoreAppsItemConfig: ODSAboutListItemConfig {

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
    ///    - feedURL: The URL to use to get data from online feed
    ///    - priority: Priority to adjust the position of the item in the list.
    public init(feedURL: URL, priority: ODSAboutListItemPriority = .moreApps) {
        title = "modules.about.apps_recirculation.title".🌐
        icon = Image("ic_mobile_apps", bundle: Bundle.ods)
        target = .destination(AnyView(MoreAppsView(feedURL: feedURL)))
        self.priority = priority
    }
}
