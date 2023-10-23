/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import Foundation

infix operator <-

extension String {

    /// Just an operator to inject as `String` one argument in localizable
    /// - Parameters:
    ///    - lhs: The localizable value to update
    ///    - rhs: The value as String to inject in `lhs`
    /// - Returns String: The final result
    static func <- (lhs: String, rhs: String) -> String {
        lhs <- [rhs]
    }

    /// Just an operator to inject as `String` array some arguments in localizable
    /// - Parameters:
    ///    - lhs: The localizable value to update
    ///    - rhs: The values as [String] to inject in `lhs`
    /// - Returns String: The final result
    static func <- (lhs: String, rhs: [String]) -> String {
        lhs.localized(with: rhs)
    }
    
    // swiftlint:disable nslocalizedstring_key
    /// Ensures the string you handle has been localized,
    /// e.g. when you store the string as String and not implicitly as LocalizedString (like done in Views, sometimes the cast fails).
    /// Could also bring some fun in the source code, remember to keep it clear of course ¯\_( ͡❛ ͜ʖ ͡❛)_/¯
    var 🌐: String {
        NSLocalizedString(self, comment: self)
    }
    // swiftlint:enable nslocalizedstring_key
    
    // swiftlint:disable nslocalizedstring_key
    func localized(with arguments: [CVarArg]) -> String {
        return String(format: NSLocalizedString(self, bundle: Bundle.main, comment: self), arguments)
    }
    // swiftlint:enable nslocalizedstring_key
}
