//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import SwiftUI

// =================================
// MARK: - About Release Description
// =================================

struct AboutReleaseDescription: Decodable {
    let version: String
    let date: Date
    let news: String
}

// ================================
// MARK: - App News List View Model
// ================================

final class AppNewsListViewModel: ObservableObject {

    @Published var releaseDescriptions: LoadingState<[AboutReleaseDescription], AppNewsListViewModel.Error>
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

    enum Error: Swift.Error {
        case resourceNotFound
        case noJSONData
        case parsingIssue
    }

    /// Loads from the local `newsFilePath` the content of the target file, then decodes as JSON and converts and stores as
    /// `[AboutReleaseDescription]` available through the _releaseDescriptions_ published property.
    func load() {

        guard FileManager().fileExists(atPath: newsFilePath) else {
            ODSLogger.error("Resource not found for AppNews")
            releaseDescriptions = .error(.resourceNotFound)
            return
        }

        guard let jsonData = try? String(contentsOfFile: newsFilePath).data(using: .utf8) else {
            ODSLogger.error("No JSON data for AppNews")
            releaseDescriptions = .error(.noJSONData)
            return
        }

        let dateFormatter = DateFormatter.formatter(for: "yyyy-MM-dd") // Format of date in the AppNews JSON file
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let decodedReleaseDescriptions = try? decoder.decode([AboutReleaseDescription].self, from: jsonData) else {
            ODSLogger.error("Parsing error for AppNews")
            releaseDescriptions = .error(.parsingIssue)
            return
        }

        ODSLogger.debug("Successfully loaded AppNews resource")
        releaseDescriptions = .loaded(decodedReleaseDescriptions)
    }
}
