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

final class ArrayExtensionTests: XCTestCase {

    // ==================
    // MARK: - Test cases
    // ==================

    func testODSAboutListItemConfigSortingOperation() {
        // Given
        let item1 = FakeAboutListItemConfig(priority: 42)
        let item2 = FakeAboutListItemConfig(priority: 118712)
        let item3 = FakeAboutListItemConfig(priority: 666)
        let items: [ODSAboutListItemConfig] = [item1, item2, item3]
        
        // When
        let sortedItems = items.sort()
        
        // Then
        XCTAssertTrue(sortedItems[0] == item2)
        XCTAssertTrue(sortedItems[1] == item3)
        XCTAssertTrue(sortedItems[2] == item1)
    }

    // ===================================
    // MARK: - Fake About List Item Config
    // ===================================

    fileprivate struct FakeAboutListItemConfig: ODSAboutListItemConfig {
        var title: String
        var icon: Image
        var target: ODSAboutListItemTarget
        var priority: ODSAboutListItemPriority

        init(priority: ODSAboutListItemPriority {
            title = "Some title"
            icon = Image(systemName: "heart")
            self.priority = priority
            target = .action({})
        }
    }
}
