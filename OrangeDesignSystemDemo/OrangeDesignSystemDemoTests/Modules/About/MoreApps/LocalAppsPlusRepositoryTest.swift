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

import Foundation
@testable import OrangeDesignSystem
import XCTest

// swiftlint:disable line_length
final class LocalAppsPlusRepositoryTests: XCTestCase {

    func testReadOfLocalData() async {
        // Given
        let localDataURL = XCTestCase.stubURL(for: "AppsPlusMock", ofType: "json", inBundleOf: LocalAppsPlusRepositoryTests.self)
        let localAppsPlusRepository: RecirculationRepositoryProtocol = LocalAppsPlusRepository(feedURL: localDataURL)

        // When
        let appsList: RecirculationAppsList
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
// swiftlint:enable line_length
