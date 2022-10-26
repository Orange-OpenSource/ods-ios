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

// MARK: Fonts

/// Defines all styles supported by Orange application for Text elements.
public enum ODSFontStyle: String, CaseIterable {
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

// MARK: Colors
public struct ODSColorDecription {
    public let assetName: String
    public let bundle: Bundle
    public let nameForLightScheme: String?
    public let nameForDarkScheme: String?
    
    public init(assetName: String,
                bundle: Bundle,
                nameForLightScheme: String? = nil,
                nameForDarkScheme: String? = nil) {
        self.assetName = assetName
        self.bundle = bundle
        self.nameForLightScheme = nameForLightScheme
        self.nameForDarkScheme = nameForDarkScheme
    }

    public var color: Color {
        Color(assetName, bundle: bundle)
    }

    public var uiColor: UIColor {
        UIColor(named: assetName, in: bundle, compatibleWith: nil) ?? .clear
    }
}

public typealias ODSColorPalette = [ODSColorDecription]

/// Used to define colors for components
public struct ODSComponentColors {

    public var accent: Color

    // Navigation bar
    public var navigationBarTitle: Color
    public var navigationBarBackground: Color
    public var navigationBarForeground: Color

    // Tab bar
    public var tabBarBackground: Color
    public var tabBarItem: Color
    public var tabBarSelectedItem: Color

    // Buttons
    public var highestEmphasisText: Color
    public var functionalPositive: Color
    public var functionalNegative: Color
    public var functionalAlert: Color
    public var functionalInfo: Color
    
    public init() {
        self.accent = .pink

        // Navigation bar
        self.navigationBarTitle = .pink
        self.navigationBarBackground = .green
        self.navigationBarForeground = .pink

        // Tab bar
        self.tabBarBackground = .green
        self.tabBarItem = .pink
        self.tabBarSelectedItem = .primary

        // Buttons
        self.highestEmphasisText = Color(UIColor.systemBackground)
        self.functionalNegative = .red
        self.functionalPositive = .green
        self.functionalInfo = .blue
        self.functionalAlert = .yellow
    }
}

// MARK: Theme
public struct ODSTheme: Identifiable, Hashable {

    public var name: String
    public var colorPalette: ODSColorPalette
    public var componentColors: ODSComponentColors
    public var font: (_ style: ODSFontStyle) -> Font

    public init() {
        name = "Default"
        colorPalette = ODSColorPalette()
        
        componentColors = ODSComponentColors()
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
