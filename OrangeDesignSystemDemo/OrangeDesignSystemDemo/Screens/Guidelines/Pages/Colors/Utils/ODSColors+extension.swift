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
