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

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count > 8 {
            return nil
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        let a = CGFloat((rgbValue & 0xFF00_0000) >> 24) / 255.0
        let r = CGFloat((rgbValue & 0x00FF_0000) >> 16) / 255.0
        let g = CGFloat((rgbValue & 0x0000_FF00) >> 8) / 255.0
        let b = CGFloat(rgbValue & 0x0000_00FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
