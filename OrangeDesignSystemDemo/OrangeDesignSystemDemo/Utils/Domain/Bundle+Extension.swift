//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

extension Bundle {

    // =========
    // MARK: API
    // =========

    var name: String {
        string(forInfoDictionaryKey: kCFBundleNameKey as String) ?? "(no name)"
    }

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
