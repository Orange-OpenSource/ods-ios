//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

public struct RGBA: Equatable {
    public let red: UInt
    public let green: UInt
    public let blue: UInt
    public let alpha: Float

    init(_ red: UInt, _ green: UInt, _ blue: UInt, _ alpha: Float = 1.0) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    public var displayableValue: String {
        return "rgb(\(red), \(green), \(blue))"
    }

    public var accessibilityLabel: String {
        "\(red), \(green), \(blue)"
    }

    public var hexa: String {
        String(format: "#%02X%02X%02X", red, green, blue)
    }
}
