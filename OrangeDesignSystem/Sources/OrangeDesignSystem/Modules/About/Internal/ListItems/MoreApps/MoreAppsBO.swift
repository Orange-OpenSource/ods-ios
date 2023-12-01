//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

// ======================
// MARK: - More Apps List
// ======================

/// Business object to gather both sections and apps ready to use for the _About module_
struct MoreAppsList {
    /// All available sections of apps
    let sections: [MoreAppsSection]
    /// All available apps without associated sections
    let apps: [MoreAppsAppDetails]
}

// =========================
// MARK: - More Apps Section
// =========================

/// Business object to gather a group of apps behind a description ready to use for the _About module_
struct MoreAppsSection {
    /// Some description for a section, e.g. "customer" or "business"
    let description: String
    /// All the apps for this section
    let apps: [MoreAppsAppDetails]
}

// =============================
// MARK: - More Apps App Details
// =============================

/// Business object modelizing details of an app ready to use for the _About module_
struct MoreAppsAppDetails {
    /// Commercial title of the app
    let title: String
    /// URL to use to load the icon of the app
    let iconURL: URL?
    /// Some commercial description for the app
    let description: String?
    /// Link to use to redirect the user to the app through the App Store
    let storeURL: URL?
}

// ================================
// MARK: - More Apps Service Errors
// ================================

/// Errors which can occur in repotitory or service layers and should be managed upside
enum MoreAppsErrors: Error {
    /// Prerequisites are not fullfilled to request the feeder service
    case badConfigurationPrerequisites
    /// Some issue occured with session or network requests, and no cache can be used
    case sessionError
    /// JSON decoding error, and nothing in cache can be used
    case jsonDecodingFailure
}

// ============================
// MARK: - More Apps Repository
// ============================

/// Abstraction layer if in the future another data feed will be used to get other available apps.
protocol MoreAppsRepositoryProtocol {
    func availableAppsList(at feedURL: URL) async throws -> MoreAppsList
}

// =========================
// MARK: - More Apps Service
// =========================

protocol MoreAppsServiceProtocol {
    func availableAppsList() async throws -> MoreAppsList
}

/// Helps to test or use some data feeds to get available apps details
struct MoreAppsService: MoreAppsServiceProtocol {
    private let feedURL: URL
    private let repository: MoreAppsRepositoryProtocol

    init(feedURL: URL, repository: MoreAppsRepositoryProtocol) {
        self.feedURL = feedURL
        self.repository = repository
    }

    /// Creates the URL to use to get data feed, then  through the `MoreAppsRepositoryProtocol` request data
    /// - Returns `MoreAppsList`: The parsed business objects
    func availableAppsList() async throws -> MoreAppsList {
        try await repository.availableAppsList(at: feedURL)
    }
}
