/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import Foundation

extension String {

    // swiftlint:disable nslocalizedstring_key
    func localized() -> String {
        NSLocalizedString(self, bundle: .ods, comment: self)
    }
    // swiftlint:enable nslocalizedstring_key

    /// - Parameters:
    ///    - argument: The unique value to insert in the localized string with `self` as key
    ///    - bundle: The `Bundle` to use to load the localizables, default is current calling module
    /// - Returns: The localized `String`
    func localized(with argument: CVarArg, using bundle: Bundle = .module) -> String {
        localized(with: [argument], using: bundle)
    }

    // swiftlint:disable nslocalizedstring_key
    /// - Parameters:
    ///    - arguments: An aray of values to insert in the localized string with `self` as key
    ///    - bundle: The `Bundle` to use to load the localizables, default is current calling module
    /// - Returns: The localized `String`
    func localized(with arguments: [CVarArg], using bundle: Bundle) -> String {
        return String(format: NSLocalizedString(self, bundle: bundle, comment: self), arguments)
    }
    // swiftlint:enable nslocalizedstring_key
}
