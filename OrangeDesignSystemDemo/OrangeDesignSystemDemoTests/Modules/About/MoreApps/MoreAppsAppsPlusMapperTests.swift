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

/// Helps to test the `MoreAppsAppsPlusMapper` to check if the data transfer objects parsed from JSON match the business objects after the mapping
final class MoreAppsAppsPlusMapperTests: XCTestCase {

    /// Test if some `AppsPlusAppDetailsDTO` can be parsed to `MoreAppsAppDetails`
    /// using local mock supposed to match the reality.
    func testAppsPlusMoreAppsAppDetailsMapper() {

        // Given
        let mockJsonPath = XCTestCase.stubPath(for: "AppsPlusAppDetailsMock", ofType: "json", inBundleOf: MoreAppsAppsPlusMapperTests.self)
        guard let jsonRawData = try? String(contentsOfFile: mockJsonPath).data(using: .utf8) else {
            fatalError("Failed to convert the mock JSON for tests!")
        }
        guard let appsPlusAppDetailsDTOMock = try? JSONDecoder().decode(AppsPlusAppDetailsDTO.self, from: jsonRawData) else {
            fatalError("Failed to process the JSON mock data!")
        }

        // When
        let moreAppsAppDetails = AppsPlusMoreAppsMapper().appDetails(from: appsPlusAppDetailsDTOMock)

        // Then
        compare(bo: moreAppsAppDetails, dto: appsPlusAppDetailsDTOMock)
    }

    /// Test if some `AppsPlusSectionDTO` can be parsed to `MoreAppsSection`
    /// using local mock supposed to match the reality.
    func testAppsPlusMoreAppsSectionMapper() {

        // Given
        let mockJsonPath = XCTestCase.stubPath(for: "AppsPlusSectionMock", ofType: "json", inBundleOf: MoreAppsAppsPlusMapperTests.self)
        guard let jsonRawData = try? String(contentsOfFile: mockJsonPath).data(using: .utf8) else {
            fatalError("Failed to convert the mock JSON for tests!")
        }
        guard let appsPlusSectionDTOMock = try? JSONDecoder().decode(AppsPlusSectionDTO.self, from: jsonRawData) else {
            fatalError("Failed to process the JSON mock data!")
        }

        // When
        let moreAppsSection = AppsPlusMoreAppsMapper().appsSection(from: appsPlusSectionDTOMock)

        // Then
        XCTAssertTrue(moreAppsSection.description == appsPlusSectionDTOMock.description)
        XCTAssertTrue(moreAppsSection.apps.count == appsPlusSectionDTOMock.apps.count)

        compare(bo: moreAppsSection.apps[0], dto: appsPlusSectionDTOMock.apps[0])
        compare(bo: moreAppsSection.apps[1], dto: appsPlusSectionDTOMock.apps[1])
    }

    /// Test if some `AppsPlusListDTO` can be parsed by the  `MoreAppsAppsPlusMapper`
    /// using local mock supposed to match the reality.
    func testAppsPlusListMapper() {

        // Given, when
        let mockJsonPath = XCTestCase.stubPath(for: "AppsPlusListMock", ofType: "json", inBundleOf: MoreAppsAppsPlusMapperTests.self)
        guard let jsonRawData = try? String(contentsOfFile: mockJsonPath).data(using: .utf8) else {
            fatalError("Failed to convert the mock JSON for tests!")
        }

        guard let appsPlusItemsMock = try? JSONDecoder().decode(AppsPlusListDTO.self, from: jsonRawData) else {
            fatalError("Failed to process the JSON mock data!")
        }

        let mapper = AppsPlusMoreAppsMapper()

        let moreAppsAppDetails = mapper.appsDetails(from: appsPlusItemsMock)
        let lonelyApps: [MoreAppsAppDetails] = appsPlusItemsMock.apps.map { appDTO in
            mapper.appDetails(from: appDTO)
        }

        let moreAppsSections = mapper.appsSections(from: appsPlusItemsMock)
        let sections: [MoreAppsSection] = appsPlusItemsMock.sections.map { sectionDTO in
            mapper.appsSection(from: sectionDTO)
        }

        // Then
        XCTAssertTrue(appsPlusItemsMock.children.count == 3) // 2 sections and 1 app outside sections

        XCTAssertTrue(lonelyApps.count == 1)
        XCTAssertTrue(lonelyApps.count == moreAppsAppDetails.count)
        compareBoth(moreAppsAppDetails[0], lonelyApps[0])

        XCTAssertTrue(sections.count == 2)
        XCTAssertTrue(sections.count == moreAppsSections.count)
        compareBoth(sections, moreAppsSections)
    }

    // ==============
    // MARK: - Helper
    // ==============

    private func compare(bo: MoreAppsAppDetails, dto: AppsPlusAppDetailsDTO) {
        XCTAssertTrue(bo.title == dto.title)
        XCTAssertTrue(bo.iconURL == URL(string: dto.iconURL))
        XCTAssertTrue(bo.description == dto.description)
        XCTAssertTrue(bo.storeURL == URL(string: dto.storeLink))
    }

    private func compareBoth(_ lhs: MoreAppsAppDetails, _ rhs: MoreAppsAppDetails) {
        XCTAssertTrue(lhs.title == rhs.title)
        XCTAssertTrue(lhs.iconURL == rhs.iconURL)
        XCTAssertTrue(lhs.description == rhs.description)
        XCTAssertTrue(lhs.storeURL == rhs.storeURL)
    }

    private func compareBoth(_ lhs: [MoreAppsSection], _ rhs: [MoreAppsSection]) {
        XCTAssertTrue(lhs.count == rhs.count)
        for (lhsItem, rhsItem) in zip(lhs, rhs) {
            XCTAssertTrue(lhsItem.description == rhsItem.description)
            XCTAssertTrue(lhsItem.apps.count == rhsItem.apps.count)
            for (lhsItemApp, rhsItemApp) in zip(lhsItem.apps, rhsItem.apps) {
                XCTAssertTrue(lhsItemApp.title == rhsItemApp.title)
                XCTAssertTrue(lhsItemApp.description == rhsItemApp.description)
                XCTAssertTrue(lhsItemApp.iconURL == rhsItemApp.iconURL)
                XCTAssertTrue(lhsItemApp.storeURL == rhsItemApp.storeURL)
            }
        }
    }
}
