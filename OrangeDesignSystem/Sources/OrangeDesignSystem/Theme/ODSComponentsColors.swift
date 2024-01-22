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

/// Used to define colors for components
public struct ODSComponentColors {

    // =======================
    // MARK: Stored Properties
    // =======================

    public var accent: Color

    // Navigation bar
    public var navigationBarTitle: Color
    public var navigationBarBackground: Color
    public var navigationBarForeground: Color

    // Tab bar
    public var tabBarBackground: Color
    public var tabBarItem: Color
    public var tabBarSelectedItem: Color

    // Tool bar
    public var toolBarBackground: Color
    public var toolBarItem: Color

    // Buttons
    public var highEmphasisText: Color
    public var functionalPositive: Color
    public var functionalNegative: Color
    public var functionalAlert: Color
    public var functionalInfo: Color

    // Bottom sheet
    public var bottomSheetHeaderBackground: Color

    // ==================
    // MARK: Initializers
    // ==================

    public init() {
        accent = .pink

        // Navigation bar
        navigationBarTitle = .pink
        navigationBarBackground = .green
        navigationBarForeground = .pink

        // Tab bar
        tabBarBackground = .green
        tabBarItem = .pink
        tabBarSelectedItem = .primary

        // Tool bar
        toolBarBackground = .pink
        toolBarItem = .green

        // Buttons
        highEmphasisText = Color(UIColor.systemBackground)
        functionalNegative = .red
        functionalPositive = .green
        functionalInfo = .blue
        functionalAlert = .yellow

        // Bottom sheet
        bottomSheetHeaderBackground = Color(UIColor.systemGray6)
    }
}
