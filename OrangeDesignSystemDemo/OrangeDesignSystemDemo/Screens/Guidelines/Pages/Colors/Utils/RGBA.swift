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

import Foundation

struct RGBA: Equatable {
    let red: UInt
    let green: UInt
    let blue: UInt
    let alpha: Float

    init(_ red: UInt, _ green: UInt, _ blue: UInt, _ alpha: Float = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    var displayableValue: String {
        return "rgb(\(red), \(green), \(blue))"
    }

    var accessibilityLabel: String {
        "\(red), \(green), \(blue)"
    }

    var hexa: String {
        String(format: "#%02X%02X%02X", red, green, blue)
    }
}
