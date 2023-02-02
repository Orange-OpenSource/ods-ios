//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import SwiftUI
import OrangeDesignSystem

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
        theme.componentColors.highestEmphasisText = .white
        
        theme.componentColors.functionalNegative = InnovationCupThemeColors.functionalNegative.colorDecription.color
        theme.componentColors.functionalPositive = InnovationCupThemeColors.functionalPositive.colorDecription.color
        theme.componentColors.functionalInfo = InnovationCupThemeColors.functionalInfo.colorDecription.color
        theme.componentColors.functionalAlert = InnovationCupThemeColors.functionalAlert.colorDecription.color

        // Fonts: use the default ones
        // theme.font = { style in }
    
        self.theme = theme
    }
}
