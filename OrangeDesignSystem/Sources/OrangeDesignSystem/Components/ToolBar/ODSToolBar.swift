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

///
/// <a href="https://system.design.orange.com/0c1af118d/p/06c413-bars-tool/b/951e5c" target="_blank">ODS Bars: Tool</a>.
///
/// A toolbar allows users to do specific actions regarding the entire page. It is placed at the bottom of the screen.
///
/// The following example shows how to build a `odsToolBar` with 2 labeled items:
///
///     struct YourView: View {
///         let description1 = ODSToolbarLabelDesription(text: "Action 1") { /* do something here */ }
///         let description2 = ODSToolbarLabelDesription(text: "Action 2") { /* do something here */ }
///         let labelItems = ODSToolbarLabeledItems(description1: description1, description2: description2)
///
///         var body: some View {
///            NavigationView {
///                ContentView()
///                .navigationBarHidden(true)
///                .odsToolBar(items: labelItems)
///             }
///         }
///     }
///

extension View {
    /// Sets labeled items (2 up to 3) in tool bar.
    ///
    /// - Parameter items: The configuration containing items description.
    ///
    /// - Returns: A tool bar with labeled items placed as decribed in design.
    ///
    public func odsToolBar(items: ODSToolbarLabeledItems) -> some View {
        toolbar {
            ODSToolbarLabelContent(items: items)
        }
    }

    /// Sets icon items (2 up to 5) in tool bar.
    ///
    /// - Parameter items: The configuration containing items description.
    ///
    /// - Returns: A tool bar with icon items placed as decribed in design.
    ///
    public func odsToolBar(items: ODSToolbarIconsItems) -> some View {
        toolbar {
            ODSToolbarIconContent(items: items)
        }
    }
}

public struct ODSToolbarLabelDesription {

    // =======================
    // MARK: Stored Properties
    // =======================

    let text: String
    let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    public init(text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
}

public struct ODSToolbarLabeledItems {

    // =======================
    // MARK: Stored Properties
    // =======================

    let description1: ODSToolbarLabelDesription
    let description2: ODSToolbarLabelDesription
    let description3: ODSToolbarLabelDesription?

    // ==================
    // MARK: Initializers
    // ==================

    public init(
        description1: ODSToolbarLabelDesription,
        description2: ODSToolbarLabelDesription,
        description3: ODSToolbarLabelDesription? = nil)
    {
        self.description1 = description1
        self.description2 = description2
        self.description3 = description3
    }
}

public struct ODSToolbarIconDesription {

    // =======================
    // MARK: Stored Properties
    // =======================

    let systemName: String
    let action: () -> Void

    // ==================
    // MARK: Initializers
    // ==================

    public init(systemName: String, action: @escaping () -> Void) {
        self.systemName = systemName
        self.action = action
    }
}

public struct ODSToolbarIconsItems {

    // =======================
    // MARK: Stored Properties
    // =======================

    let description1: ODSToolbarIconDesription
    let description2: ODSToolbarIconDesription
    let description3: ODSToolbarIconDesription?
    let description4: ODSToolbarIconDesription?
    let description5: ODSToolbarIconDesription?

    // ==================
    // MARK: Initializers
    // ==================

    public init(
        description1: ODSToolbarIconDesription,
        description2: ODSToolbarIconDesription,
        description3: ODSToolbarIconDesription? = nil,
        description4: ODSToolbarIconDesription? = nil,
        description5: ODSToolbarIconDesription? = nil)
    {
        self.description1 = description1
        self.description2 = description2
        self.description3 = description3
        self.description4 = description4
        self.description5 = description5
    }
}
