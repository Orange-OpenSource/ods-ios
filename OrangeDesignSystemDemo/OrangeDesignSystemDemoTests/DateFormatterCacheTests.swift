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

/// Helps top run tests on the _Orange Design System_ library beside simulator when needed (e.g. for l10n)
final class DateFormatterCacheTest: XCTestCase {

    override func setUp() {
        DateFormatterCache.shared.flush()
    }

    // ==================
    // MARK: - Test cases
    // ==================

    func testFormatterAvailabilityIfNotAdded() {
        // Given
        let locale = Locale(identifier: "fr")
        let dateStyle = DateFormatter.Style.short
        let timeStyle = DateFormatter.Style.none

        // When
        let formatter = DateFormatterCache.shared.formatter(for: locale, dateStyle: dateStyle, timeStyle: timeStyle)

        // Then
        XCTAssertNil(formatter)
    }

    func testFormatterAvailabilityIfAdded() {
        // Given
        let locale = Locale(identifier: "fr")
        let dateStyle = DateFormatter.Style.short
        let timeStyle = DateFormatter.Style.none
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        DateFormatterCache.shared.store(formatter: formatter)

        // When
        guard let storedFormatter = DateFormatterCache.shared.formatter(for: locale, dateStyle: dateStyle, timeStyle: timeStyle) else {
            XCTFail("Nil value returned, must not")
            return
        }

        // Then
        XCTAssertEqual(formatter.locale, storedFormatter.locale)
        XCTAssertEqual(formatter.dateStyle, storedFormatter.dateStyle)
        XCTAssertEqual(formatter.timeStyle, storedFormatter.timeStyle)
    }
}
