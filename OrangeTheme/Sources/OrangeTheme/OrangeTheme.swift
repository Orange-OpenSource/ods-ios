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

public struct OrangeThemeFactory {
    public let theme: ODSTheme
    public static let themeName = "OrangeTheme"

    public init() {
        var theme = ODSTheme()

        theme.name = OrangeThemeFactory.themeName
        theme.colors.accent = Color("coreOrange", bundle: Bundle.module)

        // Navigation bar
        theme.colors.navigationBarTitle = Color.primary
        theme.colors.navigationBarBackground = Color("componentBackground", bundle: Bundle.module)
        theme.colors.navigationBarForeground = theme.colors.accent

        // Tab bar
        theme.colors.tabBarBackground = Color("componentBackground", bundle: Bundle.module)
        theme.colors.tabBarItem = .primary
        theme.colors.tabBarSelectedItem = theme.colors.accent

        theme.colors.highestEmphasisText = Color(UIColor.systemBackground)
        theme.colors.functionalNegative = Color("functionalNegative", bundle: Bundle.module)
        theme.colors.functionalPositive = Color("functionalPositive", bundle: Bundle.module)

        theme.font = { style in
            switch style {
            case .largeTitle:
                return Font.largeTitle.bold()
            case .title1:
                return Font.title.bold()
            case .title2:
                return Font.title2.bold()
            case .title3:
                return Font.title3.bold()
            case .headline:
                return Font.headline.bold()
            case .bodyRegular:
                return Font.body
            case .bodyBold:
                return Font.body.bold()
            case .callout:
                return Font.callout
            case .subhead:
                return Font.subheadline.bold()
            case .footnote:
                return Font.footnote
            case .caption1Regular:
                return Font.caption
            case .caption1Bold:
                return Font.caption.bold()
            case .caption2:
                return Font.caption2
            }
        }

        self.theme = theme
    }
}
