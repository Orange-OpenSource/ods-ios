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
    
    /// A value filled by the CI/CD chain for debug purposes to help to match ths current app to some CI/CD build tag
    var buildTag: String? {
#if DEBUG
        nil
#else
        string(forInfoDictionaryKey: "ODSBuildTag")
#endif
    }
    
    var fullBuildType: String? {
        let type = buildType ?? ""
        var tag = ""
        if let buildTag = buildTag, !buildTag.isEmpty {
            tag = " \(buildTag)"
        }
        return "\(type)\(tag)"
    }
    
    var appIconFileName: String? {
        guard let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
              let iconFileName = iconFiles.last
        else { return nil }
        return iconFileName
    }
    
    // ============================
    // MARK: Private Implementation
    // ============================
    
    private func string(forInfoDictionaryKey key: String) -> String? {
        object(forInfoDictionaryKey: key) as? String
    }
}
