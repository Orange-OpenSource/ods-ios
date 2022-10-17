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
    
    public var accent: Color

    public init() {
        self.accent = .pink
    }
}

public struct ODSTheme: Identifiable, Hashable {

    public var name: String
    public var colors: ODSThemeColors
    public var font: (_ style: ODSThemeFontStyle) -> Font

    public init() {
        name = "FakeTheme"
        colors = ODSThemeColors()
        font = { style in
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
    }
    
    // MARK: Identifiable
    public var id: String {
        name
    }
    
    // MARK: Hashable
    public static func == (lhs: ODSTheme, rhs: ODSTheme) -> Bool {
        lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

