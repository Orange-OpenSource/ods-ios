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

/// Configuration to add in list the item that opens the AppNews page.
/// This page needs the path to the JSON file containing News.
///
/// By default, this item is placed after the item of accessibility statement. That can be changed with new priority set in the configuration.
public struct ODSAboutAppNewsItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    public private(set) var title: String
    public private(set) var icon: Image
    public private(set) var target: ODSAboutListItemTarget
    public private(set) var priority: ODSAboutListItemPriority

    private let path: String

    // =================
    // MARK: Initializer
    // =================

    /// Initializes the configuration.
    ///
    /// - Parameters:
    ///    - priority: Priority to adjust the position of the item in the list.
    ///    - path: Path to the JSON file.
    public init(priority: ODSAboutListItemPriority = .appNews, path: String) {
        self.path = path
        self.priority = priority
        title = "modules.about.app_news.title".🌐
        icon = Image("ic_taskList", bundle: Bundle.ods)
        target = .destination(AnyView(AppNewsList(viewModel: AppNewsListViewModel(fromFile: path))))
    }
}
