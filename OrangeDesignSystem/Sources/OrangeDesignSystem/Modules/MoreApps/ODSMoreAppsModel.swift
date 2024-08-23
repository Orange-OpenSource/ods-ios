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

import Combine
import Foundation
import SwiftUI

// ===========================
// MARK: - MoreApps View Model
// ===========================

@MainActor
final class ODSMoreAppsModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let service: MoreAppsService
    private let flattenApps: Bool
    private let cacheAppsIcons: Bool
    @Published var loadingState: LoadingState<MoreAppsAppsList, ODSMoreAppsModel.Error>

    // =================
    // MARK: Initializer
    // =================

    init(dataSource: ODSMoreAppsDataSource, flattenApps: Bool, cacheAppsIcons: Bool) {
        switch dataSource {
        case let .remote(feedURL):
            ODSLogger.info("AppsPlus backend will be requested to get apps to display")
            service = MoreAppsService(repository: AppsPlusRepository(feedURL: feedURL))
        case let .local(filePath):
            ODSLogger.info("Local data based on AppsPlus dump will be used to display apps")
            service = MoreAppsService(repository: LocalAppsPlusRepository(feedURL: filePath))
        }
        self.flattenApps = flattenApps
        self.cacheAppsIcons = cacheAppsIcons
        loadingState = .idle
    }

    // ===============
    // MARK: - Service
    // ===============

    /// Errors which may appear while processing the app news files
    enum Error: Swift.Error {
        case configurationError
        case unknownError
    }

    func fetchAvailableAppsList() {
        Task {
            loadingState = .loading
            do {
                let appsList = try await service.availableAppsList()
                loadingState = .loaded(flattenApps ? appsList.flattened() : appsList)
            } catch {
                if let moreAppsError = error as? ODSMoreAppsModel.Error {
                    loadingState = .error(moreAppsError)
                } else {
                    loadingState = .error(.unknownError)
                }
            }
        }
    }

    func appImage(at url: URL) -> ODSImage.Source {
        return cacheAppsIcons
            ? ODSImage.Source.cachedAsyncImage(url, Image("placeholder", bundle: Bundle.ods))
            : ODSImage.Source.asyncImage(url, Image("placeholder", bundle: Bundle.ods))
    }
}
