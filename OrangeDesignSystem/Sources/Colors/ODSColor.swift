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
import UIKit

// shortcuts
public enum ODS {

    public enum core {
        public static let orange = ODSColour.coreOrange.color
        public static let white = ODSColour.coreWhite.color
        public static let black = ODSColour.coreBlack.color
        public static let obsGrey = ODSColour.coreObsGrey.color
    }

    public enum functional {
        public static let positive = ODSColour.functionalPositive.color
        public static let negative = ODSColour.functionalNegative.color
        public static let alert = ODSColour.functionalAlert.color
        public static let info = ODSColour.functionalInfo.color
    }

    public enum supporting {
        public static let blue100 = ODSColour.supportingBlue100.color
        public static let blue200 = ODSColour.supportingBlue200.color
        public static let blue300 = ODSColour.supportingBlue300.color

        public static let green100 = ODSColour.supportingGreen100.color
        public static let green200 = ODSColour.supportingGreen200.color
        public static let green300 = ODSColour.supportingGreen300.color

        public static let yellow100 = ODSColour.supportingYellow100.color
        public static let yellow200 = ODSColour.supportingYellow200.color
        public static let yellow300 = ODSColour.supportingYellow300.color

        public static let purple100 = ODSColour.supportingPurple100.color
        public static let purple200 = ODSColour.supportingPurple200.color
        public static let purple300 = ODSColour.supportingPurple300.color

        public static let pink100 = ODSColour.supportingPink100.color
        public static let pink200 = ODSColour.supportingPink200.color
        public static let pink300 = ODSColour.supportingPink300.color
    }
}

// ==================
// MARK: - ODS Colors
// ==================

public enum ODSColour {

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

    public var onLightName: String {
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
        }
    }

    public var onDarkName: String {
        switch self {
        case .coreOrange:
            return "Orange 100"
        case .functionalPositive:
            return "Positive 100"
        case .functionalNegative:
            return "Negative 100"
        case .functionalInfo:
            return "Info 100"
        case .functionalAlert:
            return "Alert 100"
        default:
            return onLightName
        }
    }

    public func name(forScheme scheme: ColorScheme) -> String {
        if scheme == .light {
            return onLightName
        } else {
            return onDarkName
        }
    }

    public var internalName: String {
        switch self {
        // CORE
        case .coreOrange:
            return "core_orange"
        case .coreBlack:
            return "core_black"
        case .coreWhite:
            return "core_white"
        case .coreObsGrey:
            return "core_obs_grey"
        // FUNCTIONAL
        case .functionalInfo:
            return "functional_info"
        case .functionalAlert:
            return "functional_alert"
        case .functionalPositive:
            return "functional_positive"
        case .functionalNegative:
            return "functional_negative"
        // SUPPORTING
        case .supportingBlue100:
            return "supporting_blue_100"
        case .supportingBlue200:
            return "supporting_blue_200"
        case .supportingBlue300:
            return "supporting_blue_300"
        case .supportingYellow100:
            return "supporting_yellow_100"
        case .supportingYellow200:
            return "supporting_yellow_200"
        case .supportingYellow300:
            return "supporting_yellow_300"
        case .supportingGreen100:
            return "supporting_green_100"
        case .supportingGreen200:
            return "supporting_green_200"
        case .supportingGreen300:
            return "supporting_green_300"
        case .supportingPurple100:
            return "supporting_purple_100"
        case .supportingPurple200:
            return "supporting_purple_200"
        case .supportingPurple300:
            return "supporting_purple_300"
        case .supportingPink100:
            return "supporting_pink_100"
        case .supportingPink200:
            return "supporting_pink_200"
        case .supportingPink300:
            return "supporting_pink_300"
        }
    }

    public var color: Color {
        return Color(internalName, bundle: Bundle.bundle)
    }

    public var rgb: String {
        guard let rgba = Color(internalName, bundle: Bundle.bundle).rgba else {
            return ""
        }

        let red = String(format: "%.0f", rgba.red * 255)
        let green = String(format: "%.0f", rgba.green * 255)
        let blue = String(format: "%.0f", rgba.blue * 255)
        return "rgb(\(red), \(green), \(blue))"
    }

    public var hexa: String {
        let swiftUIColor = Color(internalName, bundle: Bundle.bundle)
        return swiftUIColor.hexaRGBA ?? ""
    }
}

extension Color {
    var uiColor: UIColor { .init(self) }

    typealias RGBA = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

    var rgba: RGBA? {
        var (r, g, b, a): RGBA = (0, 0, 0, 0)
        return uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) ? (r, g, b, a) : nil
    }

    var hexaRGBA: String? {
        guard let (red, green, blue, alpha) = rgba else { return nil }
        return String(format: "#%02x%02x%02x%02x",
                      Int(round(red * 255)),
                      Int(round(green * 255)),
                      Int(round(blue * 255)),
                      Int(round(alpha * 255)))
    }
}

/// A huge list of colors which are mainly binded to system colors.
///

public enum ODSColor: CaseIterable {
    public enum ColorType: Int, CaseIterable {
        case core = 0
        case functional
        case supporting
        case grey
        case basic

        public var description: String {
            switch self {
            case .core: return "Core"
            case .functional: return "Functional"
            case .supporting: return "Supporting"
            case .grey: return "Grey"
            case .basic: return "Basic"
            }
        }
    }

    // MARK: - CORE

    case coreOrange
    case coreTheme // White in light mode, black in dark mode
    case coreThemeInverse // White in dark mode, black in light mode
    case coreObsGrey700

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

    // MARK: - FUNCTIONAL

    case functionalInfo
    case functionalAlert
    case functionalPositive
    case functionalNegative

    // MARK: - GREY

    case grey200
    case grey300
    case grey400
    case grey500
    case grey600
    case grey800

    // MARK: - BASIC COLORS

    case core_orange_200
    case core_orange_100
    case core_white_100
    case core_black_900
    case core_obsgrey_700
    case functional_info_200
    case functional_info_100
    case functional_alert_200
    case functional_alert_100
    case functional_positive_200
    case functional_positive_100
    case functional_negative_200
    case functional_negative_100

    public var color: Color {
        return Color(name, bundle: Bundle.bundle)
    }

    public var type: ColorType? {
        if name.starts(with: "core") {
            return .core
        } else if name.starts(with: "functional") {
            return .functional
        } else if name.starts(with: "supporting") {
            return .supporting
        } else if name.starts(with: "grey") {
            return .grey
        } else if name.starts(with: "ods") {
            return .basic
        } else {
            return nil
        }
    }

    public var name: String {
        switch self {
        // CORE
        case .coreOrange:
            return "core_orange"
        case .coreTheme:
            return "core_theme"
        case .coreThemeInverse:
            return "core_theme_inverse"
        case .coreObsGrey700:
            return "core_obsgrey_700"

        // SUPPORTING
        case .supportingBlue100:
            return "supporting_blue_100"
        case .supportingBlue200:
            return "supporting_blue_200"
        case .supportingBlue300:
            return "supporting_blue_300"
        case .supportingYellow100:
            return "supporting_yellow_100"
        case .supportingYellow200:
            return "supporting_yellow_200"
        case .supportingYellow300:
            return "supporting_yellow_300"
        case .supportingGreen100:
            return "supporting_green_100"
        case .supportingGreen200:
            return "supporting_green_200"
        case .supportingGreen300:
            return "supporting_green_300"
        case .supportingPurple100:
            return "supporting_purple_100"
        case .supportingPurple200:
            return "supporting_purple_200"
        case .supportingPurple300:
            return "supporting_purple_300"
        case .supportingPink100:
            return "supporting_pink_100"
        case .supportingPink200:
            return "supporting_pink_200"
        case .supportingPink300:
            return "supporting_pink_300"

        // FUNCTIONAL
        case .functionalInfo:
            return "functional_info"
        case .functionalAlert:
            return "functional_alert"
        case .functionalPositive:
            return "functional_positive"
        case .functionalNegative:
            return "functional_negative"

        // GREY
        case .grey200:
            return "grey_200"
        case .grey300:
            return "grey_300"
        case .grey400:
            return "grey_400"
        case .grey500:
            return "grey_500"
        case .grey600:
            return "grey_600"
        case .grey800:
            return "grey_800"

        // BASIC
        case .core_orange_100:
            return "ods_color_core_orange_100"
        case .core_orange_200:
            return "ods_color_core_orange_200"
        case .core_white_100:
            return "ods_color_core_white_100"
        case .core_black_900:
            return "ods_color_core_black_900"
        case .core_obsgrey_700:
            return "ods_color_core_obsgrey_700"
        case .functional_info_100:
            return "ods_functional_info_100"
        case .functional_info_200:
            return "ods_functional_info_200"
        case .functional_alert_100:
            return "ods_functional_alert_100"
        case .functional_alert_200:
            return "ods_functional_alert_200"
        case .functional_positive_100:
            return "ods_functional_positive_100"
        case .functional_positive_200:
            return "ods_functional_positive_200"
        case .functional_negative_100:
            return "ods_functional_negative_100"
        case .functional_negative_200:
            return "ods_functional_negative_200"
        }
    }
}
