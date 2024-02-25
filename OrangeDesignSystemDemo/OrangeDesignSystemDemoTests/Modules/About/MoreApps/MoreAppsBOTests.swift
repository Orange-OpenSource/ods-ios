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
final class MoreAppsBOTests: XCTestCase {

    func testFlattened() {
        // Given
        let moreAppsList = availableAppsList()
        XCTAssertTrue(moreAppsList.apps.count == 3)
        XCTAssertTrue(moreAppsList.sections.count == 2)

        // When
        let flattened = moreAppsList.flattened()

        // Then
        // Apps must have been moved
        XCTAssertTrue(flattened.apps.count == 6)
        // Sections must have been deleted
        XCTAssertTrue(flattened.sections.isEmpty)
        // Order must be natural (iteration on each section to add each item in the end of the apps array)
        XCTAssertTrue(flattened.apps[0] == moreAppsList.apps[0])
        XCTAssertTrue(flattened.apps[1] == moreAppsList.apps[1])
        XCTAssertTrue(flattened.apps[2] == moreAppsList.apps[2])
        XCTAssertTrue(flattened.apps[3] == moreAppsList.sections[0].apps[0])
        XCTAssertTrue(flattened.apps[4] == moreAppsList.sections[0].apps[1])
        XCTAssertTrue(flattened.apps[5] == moreAppsList.sections[1].apps[0])
    }

    // ==============
    // MARK: - Helper
    // ==============

    private func availableAppsList() -> RecirculationAppsList {
        let mockJsonPath = XCTestCase.stubPath(for: "AppsPlusMock", ofType: "json", inBundleOf: MoreAppsServiceTests.self)
        guard let jsonRawData = try? String(contentsOfFile: mockJsonPath).data(using: .utf8) else {
            fatalError("Failed to convert the mock JSON for tests!")
        }
        guard let appsPlusDTOMock = try? JSONDecoder().decode(AppsPlusDTO.self, from: jsonRawData) else {
            fatalError("Failed to process the JSON mock data!")
        }

        let mapper = AppsPlusRecirculationMapper()
        let moreAppsAppDetails = mapper.appsDetails(from: appsPlusDTOMock.items[0])
        let moreAppsSections = mapper.appsSections(from: appsPlusDTOMock.items[0])

        return RecirculationAppsList(sections: moreAppsSections, apps: moreAppsAppDetails)
    }
}
// swiftlint:enable line_length
