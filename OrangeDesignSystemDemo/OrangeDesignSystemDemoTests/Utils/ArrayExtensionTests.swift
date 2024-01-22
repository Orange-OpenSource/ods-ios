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
import SwiftUI
import XCTest

final class ArrayExtensionTests: XCTestCase {

    // ==================
    // MARK: - Test cases
    // ==================

    // Any ODSAboutListItemConfig array must be sorted by decreasing priority
    func testODSAboutListItemConfigArraySortingOperation() {
        // Given
        let item1 = FakeAboutListItemConfig(priority: 713)
        let item2 = FakeAboutListItemConfig(priority: 42)
        let item3 = FakeAboutListItemConfig(priority: 118_712)
        let item4 = FakeAboutListItemConfig(priority: 687)
        let item5 = FakeAboutListItemConfig(priority: 666)
        let items: [ODSAboutListItemConfig] = [item1, item2, item3, item4, item5]

        // When
        let sortedItems = items.sorted()

        // Then
        XCTAssertTrue(sortedItems[0].title == item3.title)
        XCTAssertTrue(sortedItems[1].title == item1.title)
        XCTAssertTrue(sortedItems[2].title == item4.title)
        XCTAssertTrue(sortedItems[3].title == item5.title)
        XCTAssertTrue(sortedItems[4].title == item2.title)
    }

    // ===================================
    // MARK: - Fake About List Item Config
    // ===================================

    fileprivate struct FakeAboutListItemConfig: ODSAboutListItemConfig {
        var title: String
        var icon: Image
        var target: ODSAboutListItemTarget
        var priority: ODSAboutListItemPriority

        init(priority: ODSAboutListItemPriority) {
            title = "Some title \(priority)"
            icon = Image(systemName: "heart")
            self.priority = priority
            target = .action {}
        }
    }
}
