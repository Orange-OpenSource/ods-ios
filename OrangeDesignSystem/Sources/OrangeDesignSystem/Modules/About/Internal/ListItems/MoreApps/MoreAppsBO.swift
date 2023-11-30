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

/// Business object to gather both sections and apps  ready to use for the _About module_
struct MoreAppsList {
    let sections: [MoreAppsSection]
    let apps: [MoreAppsAppDetails]
}

// =========================
// MARK: - More Apps Section
// =========================

/// Business object to gather a group of apps behind a description ready to use for the _About module_
struct MoreAppsSection {
    let description: String
    let apps: [MoreAppsAppDetails]
}

// =============================
// MARK: - More Apps App Details
// =============================

/// Business object modelizing details of an app ready to use for the _About module_
struct MoreAppsAppDetails {
    let title: String
    let iconURL: URL?
    let description: String?
    let storeURL: URL?
}

// ============================
// MARK: - More Apps Repository
// ============================

/// Abstraction layer if in the future another data feed will be used to get other available apps.
protocol MoreAppsRepositoryProtocol {
    func availableAppsList() -> MoreAppsList
}

// =========================
// MARK: - More Apps Service
// =========================

protocol MoreAppsServiceProtocol {
    init(repository: MoreAppsRepositoryProtocol)
    func availableAppsList() -> MoreAppsList
}

/// Helps to test or use some data feeds to get available apps details
struct MoreAppsService: MoreAppsServiceProtocol {

    private let repository: MoreAppsRepositoryProtocol

    init(repository: MoreAppsRepositoryProtocol) {
        self.repository = repository
    }

    func availableAppsList() -> MoreAppsList {
        repository.availableAppsList()
    }
}
