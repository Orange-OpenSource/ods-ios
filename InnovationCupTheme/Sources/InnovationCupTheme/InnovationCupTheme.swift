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

import OrangeDesignSystem
import SwiftUI

enum InnovationCupThemeColors: String, CaseIterable {
    // MARK: - Core
    case accent

    // MARK: - Functional
    case functionalPositive // 2 tints (Dark & Light)
    case functionalNegative // 2 tints (Dark & Light)
    case functionalInfo // 2 tints (Dark & Light)
    case functionalAlert // 2 tints (Dark & Light)

    // MARK: Component
    case tabBarItem

    /// Get the color values from resources with its name
    public var colorDecription: ODSColorDecription {
        ODSColorDecription(assetName: rawValue, bundle: Bundle.module)
    }

    static let palette: ODSColorPalette = Self.allCases.map { $0.colorDecription }
}

public struct InnovationCupThemeFactory {
    public let theme: ODSTheme

    public init() {
        var theme = ODSTheme()
        theme.name = "InnovationCup"

        theme.colorPalette = InnovationCupThemeColors.palette
        theme.componentColors.accent = InnovationCupThemeColors.accent.colorDecription.color

        // Navigation bar
        theme.componentColors.navigationBarTitle = Color.white
        theme.componentColors.navigationBarBackground = theme.componentColors.accent
        theme.componentColors.navigationBarForeground = Color.white

        // Tab bar
        theme.componentColors.tabBarBackground = theme.componentColors.accent
        theme.componentColors.tabBarItem = InnovationCupThemeColors.tabBarItem.colorDecription.color
        theme.componentColors.tabBarSelectedItem = .white

        // Tool bar
        theme.componentColors.toolBarBackground = theme.componentColors.accent
        theme.componentColors.toolBarItem = .white

        // Buttons
        theme.componentColors.highEmphasisText = .white

        theme.componentColors.functionalNegative = InnovationCupThemeColors.functionalNegative.colorDecription.color
        theme.componentColors.functionalPositive = InnovationCupThemeColors.functionalPositive.colorDecription.color
        theme.componentColors.functionalInfo = InnovationCupThemeColors.functionalInfo.colorDecription.color
        theme.componentColors.functionalAlert = InnovationCupThemeColors.functionalAlert.colorDecription.color

        // Bottom sheet
        theme.componentColors.bottomSheetHeaderBackground = InnovationCupThemeColors.tabBarItem.colorDecription.color

        // Fonts: use the default ones
        // theme.font = { style in }

        self.theme = theme
    }
}
