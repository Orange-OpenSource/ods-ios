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


enum OrangeColors: String, CaseIterable {
    // MARK: - CORE
    case coreOrange // 2 tints (Dark & Light)
    case coreWhite
    case coreBlack
    case coreObsGrey

    // MARK: - FUNCTIONAL
    case functionalPositive // 2 tints (Dark & Light)
    case functionalNegative // 2 tints (Dark & Light)
    case functionalInfo // 2 tints (Dark & Light)
    case functionalAlert // 2 tints (Dark & Light)

    // MARK: - SUPPORTING
    case supportingBlue100
    case supportingBlue200
    case supportingBlue300
    case supportingYellow100
    case supportingYellow200
    case supportingYellow300
    case supportingGreen100
    case supportingGreen200
    case supportingGreen300
    case supportingPurple100
    case supportingPurple200
    case supportingPurple300
    case supportingPink100
    case supportingPink200
    case supportingPink300

    // MARK: - TMP
    case componentBackground
    
    public var colorDecription: ODSColorDecription {
        ODSColorDecription(assetName: rawValue,
                           bundle: Bundle.module,
                           nameForLightScheme: nameForLightScheme,
                           nameForDarkScheme: nameForDarkScheme)
    }

    var nameForLightScheme: String? {
        switch self {
        case .coreOrange:
            return "Orange 200"
        case .coreWhite:
            return "White 100"
        case .coreBlack:
            return "Black 900"
        case .coreObsGrey:
            return "OBS Grey 700"
        case .functionalPositive:
            return "Positive 200"
        case .functionalNegative:
            return "Negative 200"
        case .functionalInfo:
            return "Info 200"
        case .functionalAlert:
            return "Alert 200"
        case .supportingBlue100:
            return "Blue 100"
        case .supportingBlue200:
            return "Blue 200"
        case .supportingBlue300:
            return "Blue 300"
        case .supportingYellow100:
            return "Yellow 100"
        case .supportingYellow200:
            return "Yellow 200"
        case .supportingYellow300:
            return "Yellow 300"
        case .supportingGreen100:
            return "Green 100"
        case .supportingGreen200:
            return "Green 200"
        case .supportingGreen300:
            return "Green 300"
        case .supportingPurple100:
            return "Purple 100"
        case .supportingPurple200:
            return "Purple 200"
        case .supportingPurple300:
            return "Purple 300"
        case .supportingPink100:
            return "Pink 100"
        case .supportingPink200:
            return "Pink 200"
        case .supportingPink300:
            return "Pink 300"
        case .componentBackground:
            return nil
        }
    }
    
    var nameForDarkScheme: String? {
        switch self {
        case .coreOrange:
            return "Orange 100"
        case .coreWhite:
            return "White 100"
        case .coreBlack:
            return "Black 900"
        case .coreObsGrey:
            return "OBS Grey 700"
        case .functionalPositive:
            return "Positive 100"
        case .functionalNegative:
            return "Negative 100"
        case .functionalInfo:
            return "Info 100"
        case .functionalAlert:
            return "Alert 100"
        case .supportingBlue100:
            return "Blue 100"
        case .supportingBlue200:
            return "Blue 200"
        case .supportingBlue300:
            return "Blue 300"
        case .supportingYellow100:
            return "Yellow 100"
        case .supportingYellow200:
            return "Yellow 200"
        case .supportingYellow300:
            return "Yellow 300"
        case .supportingGreen100:
            return "Green 100"
        case .supportingGreen200:
            return "Green 200"
        case .supportingGreen300:
            return "Green 300"
        case .supportingPurple100:
            return "Purple 100"
        case .supportingPurple200:
            return "Purple 200"
        case .supportingPurple300:
            return "Purple 300"
        case .supportingPink100:
            return "Pink 100"
        case .supportingPink200:
            return "Pink 200"
        case .supportingPink300:
            return "Pink 300"
        case .componentBackground:
            return nil
        }
    }

    static let palette: ODSColorPalette = Self.allCases.map { $0.colorDecription }
}

public struct OrangeThemeFactory {
    public let theme: ODSTheme
    public static let themeName = "OrangeTheme"

    public init() {
        var theme = ODSTheme()
        
        theme.name = OrangeThemeFactory.themeName
        theme.colorPalette = OrangeColors.palette
                                               
        theme.componentColors.accent = OrangeColors.coreOrange.colorDecription.color

        // Navigation bar
        theme.componentColors.navigationBarTitle = Color.primary
        theme.componentColors.navigationBarBackground = OrangeColors.componentBackground.colorDecription.color
        theme.componentColors.navigationBarForeground = theme.componentColors.accent

        // Tab bar
        theme.componentColors.tabBarBackground = OrangeColors.componentBackground.colorDecription.color
        theme.componentColors.tabBarItem = .primary
        theme.componentColors.tabBarSelectedItem = theme.componentColors.accent

        theme.componentColors.highestEmphasisText = .black
        theme.componentColors.functionalNegative = OrangeColors.functionalNegative.colorDecription.color
        theme.componentColors.functionalPositive = OrangeColors.functionalPositive.colorDecription.color
        theme.componentColors.functionalInfo = OrangeColors.functionalInfo.colorDecription.color
        theme.componentColors.functionalAlert = OrangeColors.functionalAlert.colorDecription.color

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
