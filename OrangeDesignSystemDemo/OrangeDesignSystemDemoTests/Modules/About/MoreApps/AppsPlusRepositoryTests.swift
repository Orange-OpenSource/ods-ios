//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
@testable import OrangeDesignSystem
import XCTest

final class AppsPlusRepositoryTests: XCTestCase {

    func testCacheUsedIfError5xx() async {
        // Given
        MockURLMachine.setMock(mockHandler: { _ in
            MockResponse(httpCode: 500, data: Data())
        })

        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses?.insert(MockURLMachine.self, at: 0)
        let appsPlusRepository: MoreAppsRepositoryProtocol = AppsPlusRepository(feedURL: URL(string: "https://opensource.orange.com")!,
                                                                                urlSessionConfiguration: urlSessionConfiguration)

        cache(data: readMockData(), at: appsPlusRepository.localCacheLocation!)

        // When
        let appsList: MoreAppsList
        do {
            appsList = try await appsPlusRepository.availableAppsList()
        } catch {
            fatalError("Not the expected behavior: '\(error)'")
        }

        XCTAssertTrue(appsList.apps.count == 1)
        XCTAssertTrue(appsList.apps[0].title == "Astonishing app in cache")
        XCTAssertTrue(appsList.apps[0].description == "Some awesome cache description")
        XCTAssertTrue(appsList.apps[0].iconURL == URL(string: "https://appsplus-oma.apps-details.com/icons/cache.png"))
        XCTAssertTrue(appsList.apps[0].storeURL == URL(string: "https://itunes.apple.com/app/apple-store/cache"))
    }

    // ===============
    // MARK: - Helpers
    // ===============

    private func readMockData() -> Data {
        let mockJsonPath = XCTestCase.stubPath(for: "AppsPlusCache", ofType: "json", inBundleOf: AppsPlusRepositoryTests.self)
        guard let jsonRawData = try? String(contentsOfFile: mockJsonPath).data(using: .utf8) else {
            fatalError("Failed to convert the mock JSON for tests!")
        }
        return jsonRawData
    }

    private func cache(data payload: Data, at location: URL) {
        flushCache(at: location)
        do {
            try payload.write(to: location, options: .atomic)
        } catch {
            fatalError("Impossible to save in cache the data: '\(error.localizedDescription)'")
        }
    }

    private func flushCache(at location: URL) {
        do {
            if FileManager.default.fileExists(atPath: location.path) {
                try FileManager.default.removeItem(atPath: location.path)
            }
        } catch {
            fatalError("Failed to flush cache for tests: '\(error.localizedDescription)'")
        }
    }
}
