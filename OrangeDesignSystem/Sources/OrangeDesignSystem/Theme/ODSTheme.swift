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

import Foundation
import SwiftUI

/// Defines all styles supported by Orange application for Text elements.
public enum ODSThemeFontStyle: String, CaseIterable {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case bodyRegular
    case bodyBold
    case callout
    case subhead
    case footnote
    case caption1Regular
    case caption1Bold
    case caption2
}

public struct ODSThemeColors {
    public init(coreSurface: Color,
                coreOnSurface: Color,
                systemStatusBarBackground: Color,
                systemNavigationBarBackground: Color,
                componentBackgroundDisabled: Color,
                componentContentDisabled: Color,
                topBarBackground: Color,
                topBarContent: Color,
                bottomNavigationBarBackground: Color,
                bottomNavigationBarContent: Color,
                bottomNavigationBarContentSelected: Color,
                cardBackground: Color,
                cardContent: Color)
    {
        self.coreSurface = coreSurface
        self.coreOnSurface = coreOnSurface
        self.systemStatusBarBackground = systemStatusBarBackground
        self.systemNavigationBarBackground = systemNavigationBarBackground
        self.componentBackgroundDisabled = componentBackgroundDisabled
        self.componentContentDisabled = componentContentDisabled
        self.topBarBackground = topBarBackground
        self.topBarContent = topBarContent
        self.bottomNavigationBarBackground = bottomNavigationBarBackground
        self.bottomNavigationBarContent = bottomNavigationBarContent
        self.bottomNavigationBarContentSelected = bottomNavigationBarContentSelected
        self.cardBackground = cardBackground
        self.cardContent = cardContent
    }

    public let coreSurface: Color
    public let coreOnSurface: Color
    public let systemStatusBarBackground: Color
    public let systemNavigationBarBackground: Color
    public let componentBackgroundDisabled: Color
    public let componentContentDisabled: Color
    public let topBarBackground: Color
    public let topBarContent: Color
    public let bottomNavigationBarBackground: Color
    public let bottomNavigationBarContent: Color
    public let bottomNavigationBarContentSelected: Color
    public let cardBackground: Color
    public let cardContent: Color
}

public protocol ODSTheme {
    var name: String { get }
    var colors: ODSThemeColors { get }

    init()
    func font(for style: ODSThemeFontStyle) -> Font
}
