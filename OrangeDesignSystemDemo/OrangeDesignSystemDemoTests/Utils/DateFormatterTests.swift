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

/// Helps top run tests on the _Orange Design System_ library beside simulator when needed (e.g. for l10n)
final class DateFormatterTest: XCTestCase {

    // ==================
    // MARK: - Test cases
    // ==================

    func testFormatDateSmallFormatFrLocale() {
        // Given
        let date = date()
        let locale = Locale(identifier: "fr")
        let dateStyle = DateFormatter.Style.short
        let timeStyle = DateFormatter.Style.none

        // When
        let formattedDate = DateFormatter.format(date: date, for: locale, dateStyle: dateStyle, timeStyle: timeStyle)

        // Then
        XCTAssertTrue(formattedDate == "19/10/2023", "Value under test is '\(formattedDate)'")
    }

    func testFormatDateSmallFormatEnLocale() {
        // Given
        let date = date()
        let locale = Locale(identifier: "en")
        let dateStyle = DateFormatter.Style.short
        let timeStyle = DateFormatter.Style.none

        // When
        let formattedDate = DateFormatter.format(date: date, for: locale, dateStyle: dateStyle, timeStyle: timeStyle)

        // Then
        XCTAssertTrue(formattedDate == "10/19/23", "Value under test is '\(formattedDate)'")
    }

    // Beware of locale and preferences for languages in use on devices
    func testFormatDateSmallFormatPreferredLocale() {
        // Given
        let date = date()
        let dateStyle = DateFormatter.Style.short
        let timeStyle = DateFormatter.Style.none
        let bundle = Bundle.main

        // When
        let formattedDate = DateFormatter.localizedFormat(date: date, for: bundle, dateStyle: dateStyle, timeStyle: timeStyle)

        // Then
        XCTAssertTrue(formattedDate == "10/19/23", "Value under test is '\(formattedDate)'")
    }

    func testFormatterWithParameters() {

        // First try: Create object

        // Given
        var locale = Locale(identifier: "it")
        var dateStyle = DateFormatter.Style.short
        var timeStyle = DateFormatter.Style.full
        // When
        var formatter = DateFormatter.formatter(for: locale, dateStyle: dateStyle, timeStyle: timeStyle)
        // Then
        XCTAssertEqual(locale, formatter.locale)
        XCTAssertEqual(dateStyle, formatter.dateStyle)
        XCTAssertEqual(timeStyle, formatter.timeStyle)

        // Second try: new object lust not be the same

        // Given
        locale = Locale(identifier: "ru")
        dateStyle = DateFormatter.Style.medium
        timeStyle = DateFormatter.Style.long

        // When
        formatter = DateFormatter.formatter(for: locale, dateStyle: dateStyle, timeStyle: timeStyle)

        // Then
        XCTAssertEqual(locale, formatter.locale)
        XCTAssertEqual(dateStyle, formatter.dateStyle)
        XCTAssertEqual(timeStyle, formatter.timeStyle)
    }

    // ===============
    // MARK: - Helpers
    // ===============

    private func date() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2_023
        dateComponents.month = 10
        dateComponents.day = 19
        dateComponents.hour = 13
        dateComponents.minute = 06
        return Calendar(identifier: .gregorian).date(from: dateComponents)!
    }
}
