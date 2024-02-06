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

final class StringTests: XCTestCase {

    // ================
    // MARK: - 🌐 sugar
    // ================

    func test🌐WithCommonWording() {
        // Given
        let someWording = "Valar Morghulis"
        // When
        let result = someWording.🌐
        // Then
        XCTAssertTrue(result == someWording, "Value under test is '\(result)'")
    }

    // Expect the key "jack_miranda_liara_tali" is not available in any Localizables
    func test🌐WithMissingKey() {
        // Given
        let someFakeKey = "jack_miranda_liara_tali"
        // When
        let result = someFakeKey.🌐
        // Then
        XCTAssertTrue(result == someFakeKey, "Value under test is '\(result)'")
    }

    // Expect to have in demo app for "fr" Localizables entry "screens.components.list.details" = "Détails"
    func test🌐WithAppWording() {
        // Given
        let someAppLocalizable = "screens.components.list.details"
        // When
        let result = someAppLocalizable.🌐
        // Then
        XCTAssertTrue(result == "Détails", "Value under test is '\(result)'")
    }

    // Expect to have in lib app Localizables entry "modules.about.terms_of_service.title" = "Terms of Service"
    func test🌐WithLibWording() {
        // Given
        let someLibLocalizable = "modules.about.terms_of_service.title"
        // When
        let result = someLibLocalizable.🌐
        // Then
        XCTAssertTrue(result == "Terms of Service", "Value under test is '\(result)'")
    }

    // ===================
    // MARK: - °° operator
    // ===================

    func testOOWithCommonWording() {
        // Given
        let someWording = "Valar Morghulis"
        // When
        let result = °°someWording
        // Then
        XCTAssertTrue(result == someWording, "Value under test is '\(result)'")
    }

    // Expect the key "jack_miranda_liara_tali" is not available in any Localizables
    func testOOWithMissingKey() {
        // Given
        let someFakeKey = "jack_miranda_liara_tali"
        // When
        let result = °°someFakeKey
        // Then
        XCTAssertTrue(result == someFakeKey, "Value under test is '\(result)'")
    }

    // Expect to have in demo app for "fr" Localizables entry "screens.components.list.details" = "Détails"
    func testOOWithAppWording() {
        // Given
        let someAppLocalizable = "screens.components.list.details"
        // When
        let result = °°someAppLocalizable
        // Then
        XCTAssertTrue(result == "Détails", "Value under test is '\(result)'")
    }

    // Expect to have in lib app Localizables entry "modules.about.terms_of_service.title" = "Terms of Service"
    func testOOWithLibWording() {
        // Given
        let someLibLocalizable = "modules.about.terms_of_service.title"
        // When
        let result = °°someLibLocalizable
        // Then
        XCTAssertTrue(result == "Terms of Service", "Value under test is '\(result)'")
    }

    // ===================
    // MARK: - localized()
    // ===================

    func testLocalizedWithCommonWording() {
        // Given
        let someWording = "Valar Morghulis"
        // When
        let result = someWording.localized()
        // Then
        XCTAssertTrue(result == someWording, "Value under test is '\(result)'")
    }

    // Expect the key "jack_miranda_liara_tali" is not available in any Localizables
    func testLocalizedWithMissingKey() {
        // Given
        let someFakeKey = "jack_miranda_liara_tali"
        // When
        let result = someFakeKey.localized()
        // Then
        XCTAssertTrue(result == someFakeKey, "Value under test is '\(result)'")
    }

    // Expect to have in demo app for "fr" Localizables entry "screens.components.list.details" = "Détails"
    func testLocalizedWithAppWording() {
        // Given
        let someAppLocalizable = "screens.components.list.details"
        // When
        let result = someAppLocalizable.localized()
        // Then
        XCTAssertTrue(result == "Détails", "Value under test is '\(result)'")
    }

    // Expect to have in lib app Localizables entry "modules.about.terms_of_service.title" = "Terms of Service"
    func testLocalizedWithLibWording() {
        // Given
        let someLibLocalizable = "modules.about.terms_of_service.title"
        // When
        let result = someLibLocalizable.localized()
        // Then
        XCTAssertTrue(result == "Terms of Service", "Value under test is '\(result)'")
    }

    // ========================
    // MARK: - localized(with:)
    // ========================

    func testLocalizedWithOneArgWithCommonWording() {
        // Given
        let someWording = "Valar Morghulis"
        // When
        let result = someWording.localized(with: "No one")
        // Then
        XCTAssertTrue(result == someWording, "Value under test is '\(result)'")
    }

    // Expect the key "jack_miranda_liara_tali" is not available in any Localizables
    func testLocalizedWithOneArgWithMissingKey() {
        // Given
        let someFakeKey = "jack_miranda_liara_tali"
        // When
        let result = someFakeKey.localized(with: "Bahak")
        // Then
        XCTAssertTrue(result == someFakeKey, "Value under test is '\(result)'")
    }

    // Expect to have in demo app for "fr" Localizables entry "screens.components.card.alert_2" = "%@ tappé"
    func testLocalizedWithOneArgWithAppWording() {
        // Given
        let someAppLocalizable = "screens.components.card.alert_2"
        // When
        let result = someAppLocalizable.localized(with: "Kenny")
        // Then
        XCTAssertTrue(result == "Kenny tappé", "Value under test is '\(result)'")
    }

    // Expect to have in lib app Localizables entry "modules.about.app_information.full_version_text" = "Version %@"
    func testLocalizedWithOneArgWithLibWording() {
        // Given
        let someLibLocalizable = "modules.about.app_information.full_version_text"
        // When
        let result = someLibLocalizable.localized(with: "T101")
        // Then
        XCTAssertTrue(result == "Version T101", "Value under test is '\(result)'")
    }

    // ==========================
    // MARK: - localized(with:[])
    // ==========================

    func testLocalizedWithSeveralArgsWithCommonWording() {
        // Given
        let someWording = "Valar Morghulis"
        // When
        let result = someWording.localized(with: ["No", "one"])
        // Then
        XCTAssertTrue(result == someWording, "Value under test is '\(result)'")
    }

    // Expect the key "jack_miranda_liara_tali" is not available in any Localizables
    func testLocalizedWithSeveralArgsWithMissingKey() {
        // Given
        let someFakeKey = "jack_miranda_liara_tali"
        // When
        let result = someFakeKey.localized(with: ["Bahak", "Alpha"])
        // Then
        XCTAssertTrue(result == someFakeKey, "Value under test is '\(result)'")
    }

    // Expect to have in demo app for "fr" Localizables entry "screens.about.file_load_failure" = "Impossible de charger le fichier %@.%@"
    func testLocalizedWithSeveralArgsWithAppWording() {
        // Given
        let someAppLocalizable = "screens.about.file_load_failure"
        // When
        let result = someAppLocalizable.localized(with: ["eps3.8_stage3", "torrent"])
        // Then
        XCTAssertTrue(result == "Impossible de charger le fichier eps3.8_stage3.torrent", "Value under test is '\(result)'")
    }

    // Expect to have in lib app Localizables entry "modules.about.app_information.full_enriched_version_text" = "Version %@ (build %@)"
    func testLocalizedWithSeveralArgWithLibWording() {
        // Given
        let someLibLocalizable = "modules.about.app_information.full_enriched_version_text"
        // When
        let result = someLibLocalizable.localized(with: ["Normandy", "SR-2"])
        // Then
        XCTAssertTrue(result == "Version Normandy (build SR-2)", "Value under test is '\(result)'")
    }

    // ===================
    // MARK: - <- operator
    // ===================

    func testArrowWithOneArg() {
        // Given
        let someLocalizable = "Émiettez votre arsenic dans %@"
        let someArg = "un verre de narcotique"

        // When
        let completeSentence = someLocalizable <- someArg

        // Then
        XCTAssertTrue(completeSentence == "Émiettez votre arsenic dans un verre de narcotique", "Value under test is '\(completeSentence)'")
    }

    // Expect the key "jack_miranda_liara_tali" is not available in any Localizables
    func testArrowWithOneArgWithMissingKey() {
        // Given
        let someFakeKey = "jack_miranda_liara_tali"
        // When
        let result = someFakeKey <- "Bahak"
        // Then
        XCTAssertTrue(result == someFakeKey, "Value under test is '\(result)'")
    }

    // Expect to have in demo app for "fr" Localizables entry "screens.components.card.alert_2" = "%@ tappé";
    func testArrowWithOneArgWithAppWording() {
        // Given
        let someAppLocalizable = "screens.components.card.alert_2"
        // When
        let result = someAppLocalizable <- "Kenny"
        // Then
        XCTAssertTrue(result == "Kenny tappé", "Value under test is '\(result)'")
    }

    // Expect to have in lib app Localizables entry "modules.about.app_information.full_version_text" = "Version %@"
    func testArrowWithOneArgWithLibWording() {
        // Given
        let someLibLocalizable = "modules.about.app_information.full_version_text"
        // When
        let result = someLibLocalizable <- "T101"
        // Then
        XCTAssertTrue(result == "Version T101", "Value under test is '\(result)'")
    }

    func testArrowWithSeveralArgs() {
        // Given
        let someLocalizable = """
        Pour adoucir le mélange, \
        pressez %1$@ quartiers d'orange. \
        Ho ho, je vais en mettre %2$@
        """
        let someArgs = ["trois", "un seul"]

        // When
        let completeSentence = someLocalizable <- someArgs

        // Then
        XCTAssertTrue(completeSentence == "Pour adoucir le mélange, pressez trois quartiers d'orange. Ho ho, je vais en mettre un seul", "Value under test is '\(completeSentence)'")
    }

    // Expect the key "jack_miranda_liara_tali" is not available in any Localizables
    func testArrowWithSeveralArgsWithMissingKey() {
        // Given
        let someFakeKey = "jack_miranda_liara_tali"
        // When
        let result = someFakeKey <- ["Bahak", "Alpha"]
        // Then
        XCTAssertTrue(result == someFakeKey, "Value under test is '\(result)'")
    }

    // Expect to have in demo app for "fr" Localizables entry "screens.about.file_load_failure" = "Impossible de charger le fichier %@.%@"
    func testArrowWithSeveralArgsWithAppWording() {
        // Given
        let someAppLocalizable = "screens.about.file_load_failure"
        // When
        let result = someAppLocalizable <- ["eps3.8_stage3", "torrent"]
        // Then
        XCTAssertTrue(result == "Impossible de charger le fichier eps3.8_stage3.torrent", "Value under test is '\(result)'")
    }

    // Expect to have in lib app Localizables entry "modules.about.app_information.full_enriched_version_text" = "Version %@ (build %@)"
    func testArrowWithSeveralArgsWithLibWording() {
        // Given
        let someLibLocalizable = "modules.about.app_information.full_enriched_version_text"
        // When
        let result = someLibLocalizable <- ["Normandy", "SR-2"]
        // Then
        XCTAssertTrue(result == "Version Normandy (build SR-2)", "Value under test is '\(result)'")
    }
}
