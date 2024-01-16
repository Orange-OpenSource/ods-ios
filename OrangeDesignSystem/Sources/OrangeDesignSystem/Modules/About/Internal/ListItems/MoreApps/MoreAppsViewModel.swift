//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Combine
import Foundation
import SwiftUI

// ============================
// MARK: - More Apps View Model
// ============================

@MainActor
final class MoreAppsViewModel: ObservableObject {

    private let service: MoreAppsService
    private let flattenApps: Bool
    private let cacheAppsIcons: Bool
    @Published var loadingState: LoadingState<MoreAppsList, MoreAppsViewModel.Error>

    init(feedURL: URL, flattenApps: Bool, cacheAppsIcons: Bool) {
        service = MoreAppsService(repository: AppsPlusRepository(feedURL: feedURL))
        self.flattenApps = flattenApps
        self.cacheAppsIcons = cacheAppsIcons
        loadingState = .loading
    }

    // ===============
    // MARK: - Service
    // ===============

    /// Errors which may appear while processing the app news files
    enum Error: Swift.Error {
        case configurationError
        case unknownError
    }

    // swiftlint:disable force_cast
    func fetchAvailableAppsList() {
        Task {
            do {
                let appsList = try await service.availableAppsList()
                loadingState = .loaded(flattenApps ? appsList.flattened() : appsList)
            } catch let error where error is MoreAppsViewModel.Error {
                loadingState = .error(error as! MoreAppsViewModel.Error)
            } catch {
                loadingState = .error(.unknownError)
            }
        }
    }

    // swiftlint:enable force_cast

    func appImage(at url: URL) -> ODSImage.Source {
        if cacheAppsIcons {
            .cachedAsyncImage(url, Image("ods_empty", bundle: Bundle.ods))
        } else {
            .asyncImage(url, Image("ods_empty", bundle: Bundle.ods))
        }
    }
}
