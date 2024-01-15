//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import SwiftUI

// ================================
// MARK: - App News List View Model
// ================================

final class AppNewsListViewModel: ObservableObject {

    /// The  state containing or not the release descriptions to use based on the locale
    @Published var releaseDescriptions: LoadingState<[AboutReleaseDescription], AppNewsListViewModel.Error>
    /// Path to the app news file to display
    private let newsFilePath: String

    // =================
    // MARK: Initializer
    // =================

    init(fromFile newsFilePath: String) {
        releaseDescriptions = .loading
        self.newsFilePath = newsFilePath
    }

    // =============
    // MARK: Service
    // =============

    /// Errors which may appear while processing the app news files
    enum Error: Swift.Error {
        case resourceNotFound
        case rawParsingFailure
        case jsonParsingFailure
    }

    /// Loads from the local `newsFilePath` the content of the target file, then decodes as JSON and converts and stores as
    /// `[AboutReleaseDescription]` available through the _releaseDescriptions_ published property.
    ///
    /// It expects to have an array of objects with the following attributes (see DEVELOP.md file for further details):
    /// <pre>
    ///     {
    ///         "version": "Some x.y.z version",
    ///         "date": "date in yyyy-MM-dd format",,
    ///         "news": "News descriptions with /n symbol for new lines"
    ///     }
    /// </pre>
    func load() {

        // If file missing, nothing to do more
        guard FileManager().fileExists(atPath: newsFilePath) else {
            ODSLogger.error("Resource not found for AppNews")
            releaseDescriptions = .error(.resourceNotFound)
            return
        }

        // Read file, update cache, update state
        guard let rawData = try? String(contentsOfFile: newsFilePath).data(using: .utf8) else {
            ODSLogger.error("Failed to parse UTF8 raw data")
            releaseDescriptions = .error(.rawParsingFailure)
            return
        }

        let dateFormatter = DateFormatter.formatter(for: "yyyy-MM-dd") // Format of date in the AppNews JSON file
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let decodedReleaseDescriptions = try? decoder.decode([AboutReleaseDescription].self, from: rawData) else {
            ODSLogger.error("Parsing error for AppNews")
            releaseDescriptions = .error(.jsonParsingFailure)
            return
        }

        ODSLogger.debug("Successfully loaded AppNews resource")
        releaseDescriptions = .loaded(decodedReleaseDescriptions)
    }
}
