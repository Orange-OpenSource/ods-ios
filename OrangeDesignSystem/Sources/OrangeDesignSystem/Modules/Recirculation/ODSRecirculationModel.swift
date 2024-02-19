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

// ================================
// MARK: - Recirculation View Model
// ================================

@MainActor
final class ODSRecirculationModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let service: RecirculationService
    private let flattenApps: Bool
    private let cacheAppsIcons: Bool
    @Published var loadingState: LoadingState<RecirculationAppsList, ODSRecirculationModel.Error>

    // =================
    // MARK: Initializer
    // =================

    init(dataSource: ODSRecirculationDataSource, flattenApps: Bool, cacheAppsIcons: Bool) {
        switch dataSource {
        case let .remote(feedURL):
            ODSLogger.info("AppsPlus backend will be requested to get apps to display")
            service = RecirculationService(repository: AppsPlusRepository(feedURL: feedURL))
        case let .local(filePath):
            ODSLogger.info("Local data based on AppsPlus dump will be used to display apps")
            service = RecirculationService(repository: LocalAppsPlusRepository(feedURL: filePath))
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
                if let appsRecirculationError = error as? ODSRecirculationModel.Error {
                    loadingState = .error(appsRecirculationError)
                } else {
                    loadingState = .error(.unknownError)
                }
            }
        }
    }

    func appImage(at url: URL) -> ODSImage.Source {
        return cacheAppsIcons
            ? ODSImage.Source.cachedAsyncImage(url, Image("ods_empty", bundle: Bundle.ods))
            : ODSImage.Source.asyncImage(url, Image("ods_empty", bundle: Bundle.ods))
    }
}
