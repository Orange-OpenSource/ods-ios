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

final class LocalAppsPlusRepositoryTests: XCTestCase {

    func testReadOfLocalData() async {
        // Given
        let localDataURL = XCTestCase.stubURL(for: "AppsPlusMock", ofType: "json", inBundleOf: LocalAppsPlusRepositoryTests.self)
        let localAppsPlusRepository: MoreAppsRepositoryProtocol = LocalAppsPlusRepository(feedURL: localDataURL)

        // When
        let appsList: MoreAppsList
        do {
            appsList = try await localAppsPlusRepository.availableAppsList()
        } catch {
            fatalError("Not the expected behavior: '\(error)'")
        }

        // Then
        XCTAssertTrue(appsList.apps.count == 3)
        XCTAssertTrue(appsList.apps[0].title == "Airbox Lite")
        XCTAssertTrue(appsList.apps[1].title == "Kids Ready")
        XCTAssertTrue(appsList.apps[2].title == "Jazztel")

        XCTAssertTrue(appsList.sections.count == 2)
        XCTAssertTrue(appsList.sections[0].description == "Business apps")
        XCTAssertTrue(appsList.sections[0].apps[0].title == "Orange Pro, espace client pro")
        XCTAssertTrue(appsList.sections[0].apps[1].title == "Orange Business Lounge")
        XCTAssertTrue(appsList.sections[1].description == "Consumer")
        XCTAssertTrue(appsList.sections[1].apps[0].title == "Orange Radio")
    }
}
