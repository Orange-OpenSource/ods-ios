/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import Foundation

struct AboutReleaseDescription: Decodable {
    let version: String
    let date: Date
    let news: String
}

class AboutReleaseDescriptionsLoader {

    // =================
    // MARK: Initializer
    // =================

    init() { }

    enum Error: Swift.Error {
        case resourceNotFound
        case noJsonData
    }

    // ====================
    // MARK: Private Helper
    // ====================

    func load(from applicationNewsPath: String) throws -> [AboutReleaseDescription] {

        guard FileManager().fileExists(atPath: applicationNewsPath) else {
            throw Error.resourceNotFound
        }

        guard let jsonData = try String(contentsOfFile: applicationNewsPath).data(using: .utf8) else {
            throw Error.noJsonData
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Format of date in the AppNews JSON file
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode([AboutReleaseDescription].self, from: jsonData)
    }
}

extension AboutReleaseDescription {
    static func load() throws -> [AboutReleaseDescription] {
        return try AboutReleaseDescriptionsLoader().load(from: "AppNews")
    }
}
