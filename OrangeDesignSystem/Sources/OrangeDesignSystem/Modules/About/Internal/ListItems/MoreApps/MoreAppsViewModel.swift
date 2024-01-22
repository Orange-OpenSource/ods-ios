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

// ============================
// MARK: - More Apps View Model
// ============================

@MainActor
final class MoreAppsViewModel: ObservableObject {

    private let service: MoreAppsService
    private let flattenApps: Bool
    private let cacheAppsIcons: Bool
    @Published var loadingState: LoadingState<MoreAppsList, MoreAppsViewModel.Error>

    init(dataSource: MoreAppsViewModel.Source, flattenApps: Bool, cacheAppsIcons: Bool) {
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
        loadingState = .loading
    }

    // ==============
    // MARK: - Source
    // ==============

    /// The source of data the module must use to get all available apps
    public enum Source {
        /// Fetch some backend available at `url` with sufficient `URL` for data retrievement
        case remote(url: URL)
        /// Get useful data from some local file available at `path`
        case local(path: URL)
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
            loadingState = .loading
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
