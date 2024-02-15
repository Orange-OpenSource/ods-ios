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

import SwiftUI
import OrangeDesignSystem

final class RecirculationModuleModel: ObservableObject {
    
    // =========================
    // MARK: - Stored properties
    // =========================

    @Published var useLocalMock: Bool
    @Published var flattenAppsCategories: Bool
    @Published var cacheAppsIcons: Bool
    @Published var enableHaptics: Bool
    private let localDataSource: ODSRecirculationDataSource?
    private let remoteDataSource: ODSRecirculationDataSource?

    // ===================
    // MARK: - Initializer
    // ===================

    init() {
        flattenAppsCategories = false
        useLocalMock = true
        cacheAppsIcons = true
        enableHaptics = true
        localDataSource = Self.localDataSource
        remoteDataSource = Self.remoteDataSource
    }
    
    var hasRemoteDateSource: Bool {
        remoteDataSource != nil
    }
    
    var dataSource: ODSRecirculationDataSource {
        if useLocalMock {
            Log.info("Source of data for Recirculation module is local file")
            
            guard let localDataSource = localDataSource else {
                fatalError("Failed to URL of local data file")
            }
            return localDataSource
            
        } else {
            Log.info("Source of data for Recirculation module is Apps Plus backend")
            
            guard let remoteDataSource = remoteDataSource else {
                // Should not happen, previous controls made before
                fatalError("You were supposed to have a suitable URL, check your demo app configuration")
            }

            return remoteDataSource
        }
    }

    // =======================
    // MARK: - Private helpers
    // =======================

    /// The `URL` of the service to reach to get the list of apps to display
    private static var remoteDataSource: ODSRecirculationDataSource? {
        guard let appsPlusURL = Bundle.main.infoDictionary?["APPS_PLUS_URL"] as? String, !appsPlusURL.isEmpty else {
            Log.warning("No Apps Plus URL found in app settings")
            return nil
        }
        let currentLocale = Bundle.main.preferredLocalizations[0]
        let requestURL = "\(appsPlusURL)&lang=\(currentLocale)"
        guard let feedURL = URL(string: requestURL) else {
            Log.warning("Failed to forge the service URL to get more apps")
            return nil
        }
        return .remote(url: feedURL)
    }

    /// The `URL` pointing some JSON file, picked from backend, embeded in the app, containing the list of apps to display
    private static var localDataSource: ODSRecirculationDataSource? {
        guard let localPath = Bundle.main.url(forResource: "AppsPlus", withExtension: "json"), localPath.isFileURL else {
            return nil
        }
        return .local(path: localPath)
    }
}
