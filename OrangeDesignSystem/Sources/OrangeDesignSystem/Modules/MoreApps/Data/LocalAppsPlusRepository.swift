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

/// Parses local JSON data from file, supposing to be Apps Plus data
struct LocalAppsPlusRepository: MoreAppsRepositoryProtocol {

    // =======================
    // MARK: Stored properties
    // =======================

    private let feedURL: URL
    var localCacheLocation: URL?

    // =================
    // MARK: Initializer
    // =================

    init(feedURL: URL) {
        self.feedURL = feedURL
        localCacheLocation = nil
    }

    // =======================================
    // MARK: MoreAppsRepositoryProtocol - Impl
    // =======================================

    func availableAppsList() async throws -> MoreAppsAppsList {
        do {
            let rawData = try Data(contentsOf: feedURL)
            let appsPlusAppsList: AppsPlusListDTO = try JSONDecoder().decode(AppsPlusDTO.self, from: rawData).items[0]
            let mapper = AppsPlusToMoreAppsMapper()
            let apps = mapper.appsDetails(from: appsPlusAppsList)
            let sections = mapper.appsSections(from: appsPlusAppsList)
            return MoreAppsAppsList(sections: sections, apps: apps)
        } catch {
            ODSLogger.error("(ノಠ益ಠ)ノ彡┻━┻ Failed to decode local AppsPlus file: '\(error.localizedDescription)'")
            throw MoreAppsServiceErrors.jsonDecodingFailure
        }
    }
}
