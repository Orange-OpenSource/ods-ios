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

extension Bundle {

    // =========
    // MARK: API
    // =========

    var marketingVersion: String {
        string(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "0.0"
    }

    var buildNumber: String? {
        string(forInfoDictionaryKey: kCFBundleVersionKey as String)
    }

    var buildType: String? {
        #if DEBUG
        "ALPHA"
        #else
        string(forInfoDictionaryKey: "ODSBuildType")
        #endif
    }

    // ============================
    // MARK: Private Implementation
    // ============================

    private func string(forInfoDictionaryKey key: String) -> String? {
        object(forInfoDictionaryKey: key) as? String
    }
}
