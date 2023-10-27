/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

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
        
        //Then
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
        
        //Then
        XCTAssertTrue(formattedDate == "10/19/23", "Value under test is '\(formattedDate)'")
    }
    
    /*
     Warning: We suppose for this test case the simulator used for tests:
     - has french in first system language then english in second
     - has english and french in app languages
     - has french selected in app language
     */
    func testFormatDateSmallFormatPreferredLocale() {
        // Given
        let date = date()
        let dateStyle = DateFormatter.Style.short
        let timeStyle = DateFormatter.Style.none
        let bundle = Bundle.main
        
        // When
        let formattedDate = DateFormatter.localizedFormat(date: date, for: bundle, dateStyle: dateStyle, timeStyle: timeStyle)
        
        //Then
        XCTAssertTrue(formattedDate == "19/10/2023", "Value under test is '\(formattedDate)'")
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
        dateComponents.year = 2023
        dateComponents.month = 10
        dateComponents.day = 19
        dateComponents.hour = 13
        dateComponents.minute = 06
        return Calendar(identifier: .gregorian).date(from: dateComponents)!
    }
}
