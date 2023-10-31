//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
