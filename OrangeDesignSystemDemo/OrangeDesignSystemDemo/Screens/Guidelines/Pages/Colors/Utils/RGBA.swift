//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
