//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
// 
// This software is distributed under the MIT licence,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
// 
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System 
//

import Foundation

/// Parses local JSON data from file, supposing to be Apps Plus data
struct LocalAppsPlusRepository: RecirculationRepositoryProtocol {

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

    func availableAppsList() async throws -> AppsPlusListDTO {
        var appsPlusAppsList: AppsPlusListDTO
        do {
            let rawData = try Data(contentsOf: feedURL)
            appsPlusAppsList = try JSONDecoder().decode(AppsPlusDTO.self, from: rawData).items[0]
        } catch {
            ODSLogger.error("(ノಠ益ಠ)ノ彡┻━┻ Failed to decode local AppsPlus file: '\(error.localizedDescription)'")
            throw RecirculationServiceErrors.jsonDecodingFailure
        }

        return appsPlusAppsList
    }
}
