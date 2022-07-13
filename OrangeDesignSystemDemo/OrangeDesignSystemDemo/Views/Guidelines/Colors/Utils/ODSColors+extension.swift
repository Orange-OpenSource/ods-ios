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

import OrangeDesignSystem
import SwiftUI

extension ODSColor {

    func color(forScheme scheme: ColorScheme) -> Color {
        let rgbColor = rgb(forScheme: scheme)
        return Color(red: Double(rgbColor.red) / 255.0,
                     green: Double(rgbColor.green) / 255.0,
                     blue: Double(rgbColor.blue) / 255.0)
    }

    func rgb(forScheme scheme: ColorScheme) -> RGB {
        switch self {
        case .coreOrange:
            return scheme == .light ? RGB(241, 110, 0) : RGB(255, 121, 0)
        case .coreWhite:
            return RGB(255, 255, 255)
        case .coreBlack:
            return RGB(0, 0, 0)
        case .coreObsGrey:
            return RGB(89, 89, 89)
        case .functionalPositive:
            return scheme == .light ? RGB(34, 135, 34) : RGB(50, 200, 50)
        case .functionalNegative:
            return scheme == .light ? RGB(205, 60, 20) : RGB(213, 63, 21)
        case .functionalInfo:
            return scheme == .light ? RGB(65, 112, 216) : RGB(82, 126, 219)
        case .functionalAlert:
            return scheme == .light ? RGB(143, 114, 0) : RGB(255, 204, 0)
        case .supportingBlue100:
            return RGB(181, 232, 247)
        case .supportingBlue200:
            return RGB(75, 180, 230)
        case .supportingBlue300:
            return RGB(8, 94, 189)
        case .supportingYellow100:
            return RGB(255, 246, 182)
        case .supportingYellow200:
            return RGB(255, 210, 0)
        case .supportingYellow300:
            return RGB(255, 180, 0)
        case .supportingGreen100:
            return RGB(184, 235, 214)
        case .supportingGreen200:
            return RGB(80, 190, 135)
        case .supportingGreen300:
            return RGB(10, 110, 49)
        case .supportingPurple100:
            return RGB(217, 194, 240)
        case .supportingPurple200:
            return RGB(168, 133, 216)
        case .supportingPurple300:
            return RGB(73, 33, 145)
        case .supportingPink100:
            return RGB(255, 232, 247)
        case .supportingPink200:
            return RGB(255, 180, 230)
        case .supportingPink300:
            return RGB(255, 138, 212)

        // Tmp
        case .componentBackground:
            return scheme == .light ? RGB(249, 249, 249) : RGB(28, 28, 28)
        case .componentBackground2:
            return scheme == .light ? RGB(255, 255, 255) : RGB(28, 28, 28)
        case .primaryBackground:
            return scheme == .light ? RGB(255, 255, 255) : RGB(0, 0, 0)
        }
    }

    func hexa(forScheme scheme: ColorScheme) -> String {
        let rgb = self.rgb(forScheme: scheme)
        return String(format: "#%02x%02x%02x",
                      Int(rgb.red),
                      Int(rgb.green),
                      Int(rgb.blue)).uppercased()
    }

    func displayName(forScheme scheme: ColorScheme) -> String {
        switch self {
        case .coreOrange:
            return scheme == .light ? "Orange 200" : "Orange 100"
        case .coreWhite:
            return "White 100"
        case .coreBlack:
            return "Black 900"
        case .coreObsGrey:
            return "OBS Grey 700"
        case .functionalPositive:
            return scheme == .light ? "Positive 200" : "Positive 100"
        case .functionalNegative:
            return scheme == .light ? "Negative 200" : "Negative 100"
        case .functionalInfo:
            return scheme == .light ? "Info 200" : "Info 100"
        case .functionalAlert:
            return scheme == .light ? "Alert 200" : "Alert 100"
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

        // Tmp
        case .componentBackground:
            return "Component background"
        case .componentBackground2:
            return "Component background 2"
        case .primaryBackground:
            return "Primary background"
        }
    }
}
