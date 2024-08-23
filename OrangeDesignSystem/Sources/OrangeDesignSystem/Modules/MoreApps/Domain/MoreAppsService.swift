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

// ===============================
// MARK: - MoreApps Service Errors
// ===============================

/// Errors which can occur in repository or service layers and should be managed upside
enum MoreAppsServiceErrors: Error {
    /// Prerequisites are not fullfilled to request the feeder service
    case badConfigurationPrerequisites
    /// Some issue occured with session or network requests, and no cache can be used
    case sessionError
    /// JSON decoding error, and nothing in cache can be used
    case jsonDecodingFailure
}

// ========================
// MARK: - MoreApps Service
// ========================

/// Helps to test or use some data feeds to get available apps details
struct MoreAppsService: MoreAppsServiceProtocol {
    private let repository: MoreAppsRepositoryProtocol

    init(repository: MoreAppsRepositoryProtocol) {
        self.repository = repository
    }

    /// Creates the URL to use to get data feed, then  through the `MoreAppsRepositoryProtocol` request data
    /// - Returns `MoreAppsAppsList`: The parsed business objects
    func availableAppsList() async throws -> MoreAppsAppsList {
        try await repository.availableAppsList()
    }
}
