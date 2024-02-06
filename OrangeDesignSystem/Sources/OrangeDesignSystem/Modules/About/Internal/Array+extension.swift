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

extension Array where Element == ODSAboutListItemConfig {

    /// Returns a sorted `Array` of `ODSAboutListItemConfig` using `priority` where
    /// higher priority are at the beginning of the array.
    /// - Returns: A new array
    func sorted() -> [ODSAboutListItemConfig] {
        sorted(by: { $0.priority > $1.priority })
    }
}
