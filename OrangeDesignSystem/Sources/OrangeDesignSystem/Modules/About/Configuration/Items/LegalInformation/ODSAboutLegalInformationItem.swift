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

/// Configuration to add in list the item that opens the LegalInformation page.
/// This page can be a webview or native view.
///
/// By default, this item is placed after the item of App News. That can be changed with new priority set in the configuration.
public struct ODSAboutLegalInformationItemConfig: ODSAboutListItemConfig {

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
    ///    - priority: Priority to adjust the position of the item in the list.
    ///    - legalInformation: A view builder to create a view that describes the `legalInformation`.
    public init<LegalInformation>(priority: ODSAboutListItemPriority = .legalInformation, @ViewBuilder legalInformation: () -> LegalInformation) where LegalInformation: View {
        title = "modules.about.legal_information.title".🌐
        icon = Image("ic_legal", bundle: Bundle.ods)
        self.priority = priority
        target = .destination(AnyView(legalInformation()))
    }
}
