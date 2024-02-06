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

/// Struct for user defaults management with wrapper to as to read and write values which can be shared
@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    let storage: UserDefaults

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
        storage = .standard
    }

    var wrappedValue: T {
        get {
            storage.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Remove value if T is an optional and is nil otherwise storage.set(nil) will crash
            if let optionalType = newValue as? OptionalType, optionalType.hasValue {
                storage.removeObject(forKey: key)
            } else {
                storage.set(newValue, forKey: key)
            }
        }
    }
}

private protocol OptionalType {
    var hasValue: Bool { get }
}

extension Optional: OptionalType {
    var hasValue: Bool {
        self == nil
    }
}
