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

    /// Ensures the string you handle has been localized,
    /// e.g. when you store the string as String and not implicitly as LocalizedString (like done in Views, sometimes the cast fails).
    /// Could also bring some fun in the source code, remember to keep it clear of course ¯\_( ͡❛ ͜ʖ ͡❛)_/¯
    var 🌐: String {
        NSLocalizedString(self, comment: self)
    }
    
    func localized(with arguments: [CVarArg]) -> String {
        return String(format: NSLocalizedString(self, bundle: Bundle.main, comment: self), arguments)
    }
}
// swiftlint:enable nslocalizedstring_key
