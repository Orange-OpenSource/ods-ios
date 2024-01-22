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

import SwiftUI

// MARK: Theme EnvironmentKey
private struct Theme: EnvironmentKey {

    static let defaultValue = ODSTheme()
}

// MARK: Theme Environment value

extension EnvironmentValues {
    public var theme: ODSTheme {
        get {
            self[Theme.self]
        }
        set {
            self[Theme.self] = newValue
        }
    }
}
