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

/// Configuration to add in list the item that opens the application page on the Apple App Store.
///
/// By default, this item is placed after the item of More Apps. That can be changed with new priority set in the configuration.
public struct ODSAboutRateTheAppItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    public private(set) var title: String
    public private(set) var icon: Image
    public private(set) var target: ODSAboutListItemTarget
    public private(set) var priority: ODSAboutListItemPriority

    private let storeUrl: URL

    // =================
    // MARK: Initializer
    // =================

    /// Initializes the configuration.
    ///
    /// - Parameters:
    ///    - priority: Priority to adjust the position of the item in the list.
    ///    - storeUrl: URL of the application on the store.
    public init(priority: ODSAboutListItemPriority = .rateTheApp, storeUrl: URL) {
        title = "modules.about.rate.title".🌐
        icon = Image("ic_review", bundle: Bundle.ods)
        self.priority = priority
        self.storeUrl = storeUrl
        target = .action { UIApplication.shared.open(storeUrl) }
    }
}
