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
@testable import OrangeDesignSystemDemo
import SwiftUI
import XCTest

// swiftlint:disable line_length
final class ODSAboutListItemPriorityTests: XCTestCase {

    // ==================
    // MARK: - Test cases
    // ==================

    func testAboutItemsPriorityHierarchy() {
        XCTAssertTrue(ODSAboutListItemPriority.privacyPolicy > ODSAboutListItemPriority.termOfService)
        XCTAssertTrue(ODSAboutListItemPriority.termOfService > ODSAboutListItemPriority.accessibilityStatement)

        XCTAssertTrue(ODSAboutListItemPriority.accessibilityStatement > ODSAboutListItemPriority.appNews)
        XCTAssertTrue(ODSAboutListItemPriority.appNews > ODSAboutListItemPriority.legalInformation)
        XCTAssertTrue(ODSAboutListItemPriority.legalInformation > ODSAboutListItemPriority.moreApps)
        XCTAssertTrue(ODSAboutListItemPriority.moreApps > ODSAboutListItemPriority.rateTheApp)
    }

    func testAboutItemsSortingByPriority() {
        // Given
        let privacyPoliceItem = AboutPrivacyPolicyItem(policy: ODSPrivacyPolicy.webview(.url(Bundle.main.url(forResource: "PrivacyNotice", withExtension: "html")!)))
        let termOfServiceItem = AboutTermOfServiceItem(termsOfService: fakeView)
        let accessiblityStatementItem = AboutAccessibilityStatementItemConfig(statementConfig: ODSAboutAccessibilityStatement(fileName: "AccessibilityStatement", reportDetail: URL(string: "https://la-va11ydette.orange.com/")!))
        let appNewsItem = ODSAboutAppNewsItemConfig(path: "")
        let legalInformationItem = ODSAboutLegalInformationItemConfig(legalInformation: fakeView)
        let moreAppsItem = ODSRecirculationItemConfig(dataSource: .remote(url: URL(string: "https://opensource.orange.com/")!))
        let rateTheAppItem = ODSAboutRateTheAppItemConfig(storeUrl: URL(string: "https://www.apple.com/app-store/")!)
        let aboutDesignGuidelinesItem = AboutDesignGuidelinesItemConfig(priority: 202)
        let aboutChangelogItem = AboutChangelogItemConfig(priority: 200)

        // When
        var aboutItemsConfig: [ODSAboutListItemConfig] = [privacyPoliceItem, termOfServiceItem, accessiblityStatementItem, appNewsItem, legalInformationItem, moreAppsItem, rateTheAppItem, aboutDesignGuidelinesItem, aboutChangelogItem]
        aboutItemsConfig.shuffle() // Just to be sure the array is a bit shuffled
        let sortedAboutItemsConfig = aboutItemsConfig.sorted()

        // Then
        XCTAssertTrue(sortedAboutItemsConfig[0] is AboutDesignGuidelinesItemConfig) // 202 (hard-coded)
        XCTAssertTrue(sortedAboutItemsConfig[1] is AboutChangelogItemConfig) // 200 (hard-coded)
        XCTAssertTrue(sortedAboutItemsConfig[2] is AboutPrivacyPolicyItem) // 102 (default)
        XCTAssertTrue(sortedAboutItemsConfig[3] is AboutTermOfServiceItem) // 101 (default)
        XCTAssertTrue(sortedAboutItemsConfig[4] is AboutAccessibilityStatementItemConfig) // 100 (default)
        XCTAssertTrue(sortedAboutItemsConfig[5] is ODSAboutAppNewsItemConfig) // 60 (default)
        XCTAssertTrue(sortedAboutItemsConfig[6] is ODSAboutLegalInformationItemConfig) // 50 (default)
        XCTAssertTrue(sortedAboutItemsConfig[7] is ODSRecirculationItemConfig) // 40 (default)
        XCTAssertTrue(sortedAboutItemsConfig[8] is ODSAboutRateTheAppItemConfig) // 30 (default)
    }

    @ViewBuilder
    private func fakeView() -> some View {
        AnyView(EmptyView())
    }
}
// swiftlint:enable line_length
