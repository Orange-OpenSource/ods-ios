//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
