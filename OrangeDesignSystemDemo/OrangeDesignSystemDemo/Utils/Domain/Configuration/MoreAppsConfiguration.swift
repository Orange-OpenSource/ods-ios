//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

/// Helps to provide the most suitable configuration for the _More Apps_ feature in the _About module_.
/// Gets the suitable data somewhere in the app side to bring it to the ODS library side.
struct MoreAppsConfiguration {

    var appsPlusURL: URL {
        buildAppsPlusURL()
    }

    /// Reads from main `Bundle``infoDictionary` the URL of the _Apps Plus_ backend to reach (at **APPS_PLUS_URL**)
    /// Then adds the current locale as a _lang_ argument, and tries to forge the final `URL`.
    /// - Returns `URL?`: The final `URL` ready to use, or `nil` if the **APPS_PLUS_URL** was not found.
    private func buildAppsPlusURL() -> URL {
        guard let appsPlusURL = Bundle.main.infoDictionary?["APPS_PLUS_URL"] else {
            fatalError("No Apps Plus URL found in app settings")
        }
        let currentLocale = Bundle.main.preferredLocalizations[0]
        let requestURL = "\(appsPlusURL)&lang=\(currentLocale)"
        guard let feedURL = URL(string: requestURL) else {
            fatalError("Failed to forge the service URL to get more apps")
        }
        return feedURL
    }
}
