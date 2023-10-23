/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import Foundation
@testable import OrangeDesignSystemDemo
import XCTest

final class StringTests: XCTestCase {
    
    // ==================================
    // MARK: - Extension for localizables
    // ==================================
    
    func testOperatorWithOneArg() {
        // Given
        let someLocalizable = "Émiettez votre arsenic dans %@"
        let someArg = "un verre de narcotique"
        
        // When
        let completeSentence = someLocalizable <- someArg
        
        // Then
        XCTAssertTrue(completeSentence == "Émiettez votre arsenic dans un verre de narcotique", "Value under test is '\(completeSentence)'")
    }
    
    func testOperatorWithOSeveralArgs() {
        // Given
        let someLocalizable = """
        Pour adoucir le mélange, \
        pressez %@ quartiers d'orange. \
        Ho ho, je vais en mettre %@
        """
        let someArgs = ["trois", "un seul"]
        
        // When
        let completeSentence = someLocalizable <- someArgs
        
        // Then
        XCTAssertTrue(completeSentence == "Pour adoucir le mélange, pressez trois quartiers d'orange. Ho ho, je vais en mettre un seul", "Value under test is '\(completeSentence)'")
    }
}
