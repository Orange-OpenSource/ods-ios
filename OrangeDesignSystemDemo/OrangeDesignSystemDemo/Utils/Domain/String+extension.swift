/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import Foundation

// swiftlint:disable nslocalizedstring_key
extension String {

    var 🌐: String {
        NSLocalizedString(self, comment: self)
    }
    
    func localized(with arguments: [CVarArg], using bundle: Bundle) -> String {
        return String(format: NSLocalizedString(self, bundle: bundle, comment: self), arguments)
    }
}
// swiftlint:enable nslocalizedstring_key
