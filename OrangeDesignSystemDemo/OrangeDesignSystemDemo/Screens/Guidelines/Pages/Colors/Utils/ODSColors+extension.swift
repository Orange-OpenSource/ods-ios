//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

extension UIColor {
    func rgba(colorScheme: ColorScheme? = nil) -> RGBA {

        var color = self

        if let colorScheme = colorScheme {
            let currentTrait = UITraitCollection(userInterfaceStyle: colorScheme == .light ? .light : .dark)

            color = resolvedColor(with: currentTrait)
        }

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return RGBA(UInt(round(red * 255)), UInt(round(green * 255)), UInt(round(blue * 255)), Float(alpha))
    }

    func hexa(colorScheme: ColorScheme? = nil) -> String {
        rgba(colorScheme: colorScheme).hexa
    }
}
