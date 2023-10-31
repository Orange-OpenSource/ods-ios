//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

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
    case supportingBlue400
    case supportingBlue500
    case supportingBlue600
    case supportingYellow100
    case supportingYellow200
    case supportingYellow300
    case supportingYellow400
    case supportingYellow500
    case supportingYellow600
    case supportingGreen100
    case supportingGreen200
    case supportingGreen300
    case supportingGreen400
    case supportingGreen500
    case supportingGreen600
    case supportingPurple100
    case supportingPurple200
    case supportingPurple300
    case supportingPurple400
    case supportingPurple500
    case supportingPurple600
    case supportingPink100
    case supportingPink200
    case supportingPink300
    case supportingPink400
    case supportingPink500
    case supportingPink600
    case supportingOrganic100
    case supportingOrganic200
    case supportingOrganic300
    case supportingOrganic400
    case supportingOrganic500
    case supportingOrganic600

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
        case .supportingBlue400:
            return "Blue 400"
        case .supportingBlue500:
            return "Blue 500"
        case .supportingBlue600:
            return "Blue 600"
        case .supportingYellow100:
            return "Yellow 100"
        case .supportingYellow200:
            return "Yellow 200"
        case .supportingYellow300:
            return "Yellow 300"
        case .supportingYellow400:
            return "Yellow 400"
        case .supportingYellow500:
            return "Yellow 500"
        case .supportingYellow600:
            return "Yellow 600"
        case .supportingGreen100:
            return "Green 100"
        case .supportingGreen200:
            return "Green 200"
        case .supportingGreen300:
            return "Green 300"
        case .supportingGreen400:
            return "Green 400"
        case .supportingGreen500:
            return "Green 500"
        case .supportingGreen600:
            return "Green 600"
        case .supportingPurple100:
            return "Purple 100"
        case .supportingPurple200:
            return "Purple 200"
        case .supportingPurple300:
            return "Purple 300"
        case .supportingPurple400:
            return "Purple 400"
        case .supportingPurple500:
            return "Purple 500"
        case .supportingPurple600:
            return "Purple 600"
        case .supportingPink100:
            return "Pink 100"
        case .supportingPink200:
            return "Pink 200"
        case .supportingPink300:
            return "Pink 300"
        case .supportingPink400:
            return "Pink 400"
        case .supportingPink500:
            return "Pink 500"
        case .supportingPink600:
            return "Pink 600"
        case .supportingOrganic100:
            return "Orangic 100"
        case .supportingOrganic200:
            return "Orangic 200"
        case .supportingOrganic300:
            return "Orangic 300"
        case .supportingOrganic400:
            return "Orangic 400"
        case .supportingOrganic500:
            return "Orangic 500"
        case .supportingOrganic600:
            return "Orangic 600"
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
        case .supportingBlue400:
            return "Blue 400"
        case .supportingBlue500:
            return "Blue 500"
        case .supportingBlue600:
            return "Blue 600"
        case .supportingYellow100:
            return "Yellow 100"
        case .supportingYellow200:
            return "Yellow 200"
        case .supportingYellow300:
            return "Yellow 300"
        case .supportingYellow400:
            return "Yellow 400"
        case .supportingYellow500:
            return "Yellow 500"
        case .supportingYellow600:
            return "Yellow 600"
        case .supportingGreen100:
            return "Green 100"
        case .supportingGreen200:
            return "Green 200"
        case .supportingGreen300:
            return "Green 300"
        case .supportingGreen400:
            return "Green 400"
        case .supportingGreen500:
            return "Green 500"
        case .supportingGreen600:
            return "Green 600"
        case .supportingPurple100:
            return "Purple 100"
        case .supportingPurple200:
            return "Purple 200"
        case .supportingPurple300:
            return "Purple 300"
        case .supportingPurple400:
            return "Purple 400"
        case .supportingPurple500:
            return "Purple 500"
        case .supportingPurple600:
            return "Purple 600"
        case .supportingPink100:
            return "Pink 100"
        case .supportingPink200:
            return "Pink 200"
        case .supportingPink300:
            return "Pink 300"
        case .supportingPink400:
            return "Pink 400"
        case .supportingPink500:
            return "Pink 500"
        case .supportingPink600:
            return "Pink 600"
        case .supportingOrganic100:
            return "Orangic 100"
        case .supportingOrganic200:
            return "Orangic 200"
        case .supportingOrganic300:
            return "Orangic 300"
        case .supportingOrganic400:
            return "Orangic 400"
        case .supportingOrganic500:
            return "Orangic 500"
        case .supportingOrganic600:
            return "Orangic 600"
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

        // Tool bar
        theme.componentColors.toolBarBackground = Color(UIColor.systemBackground)
        theme.componentColors.toolBarItem = theme.componentColors.accent

        // Buttons
        theme.componentColors.highEmphasisText = .black
        theme.componentColors.functionalNegative = OrangeColors.functionalNegative.colorDecription.color
        theme.componentColors.functionalPositive = OrangeColors.functionalPositive.colorDecription.color
        theme.componentColors.functionalInfo = OrangeColors.functionalInfo.colorDecription.color
        theme.componentColors.functionalAlert = OrangeColors.functionalAlert.colorDecription.color

        // Bottom sheet
        theme.componentColors.bottomSheetHeaderBackground = OrangeColors.componentBackground.colorDecription.color

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
