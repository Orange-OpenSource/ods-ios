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

final class AppNewsListViewModelTests: XCTestCase {

    // ==================
    // MARK: - Test cases
    // ==================

    func testAppNewsListViewModel_newInstance() {
        // Given
        let viewModel = AppNewsListViewModel(fromFile: "")

        // When
        let state = viewModel.releaseDescriptions

        // Then
        var testPassed = false
        switch state {
        case .loading:
            testPassed = true
        default:
            testPassed = false
        }
        XCTAssertTrue(testPassed)
    }

    func testAppNewsListViewModel_load_noExistingFile() {
        // Given
        let viewModel = AppNewsListViewModel(fromFile: "polynectar.recette")

        // When
        viewModel.load()
        let state = viewModel.releaseDescriptions

        // Then
        switch state {
        case let .error(error):
            XCTAssertTrue(error == AppNewsListViewModel.Error.resourceNotFound, "Supposed to have an AppNewsListViewModel.Error.resourceNotFound instead of \(error)")
        default:
            XCTFail("Supposed to have an AppNewsListViewModel.Error.resourceNotFound")
        }
    }

    func testAppNewsListViewModel_load_notStringFile() {
        // Given
        let viewModel = AppNewsListViewModel(fromFile: XCTestCase.stubPath(for: "NotStringFile", ofType: "jpg", inBundleOf: AppNewsListViewModelTests.self))

        // When
        viewModel.load()
        let state = viewModel.releaseDescriptions

        // Then
        switch state {
        case let .error(error):
            XCTAssertTrue(error == AppNewsListViewModel.Error.rawParsingFailure, "Supposed to have an AppNewsListViewModel.Error.rawParsingFailure instead of \(error)")
        default:
            XCTFail("Supposed to have an AppNewsListViewModel.Error.rawParsingFailure")
        }
    }

    func testAppNewsListViewModel_load_badJSONContent() {
        // Given
        let viewModel = AppNewsListViewModel(fromFile: XCTestCase.stubPath(for: "FileWithoutJson", ofType: "json", inBundleOf: AppNewsListViewModelTests.self))

        // When
        viewModel.load()
        let state = viewModel.releaseDescriptions

        // Then
        switch state {
        case let .error(error):
            XCTAssertTrue(error == AppNewsListViewModel.Error.jsonParsingFailure, "Supposed to have an AppNewsListViewModel.Error.jsonParsingFailure instead of \(error)")
        default:
            XCTFail("Supposed to have an AppNewsListViewModel.Error.jsonParsingFailure")
        }
    }

    // "Not compliant" means date without expected format in JSON for example, i.e. requirements unmatched in view model parsing
    func testAppNewsListViewModel_load_notCompliantObjects_badDateFormat() {
        // Given
        let viewModel = AppNewsListViewModel(fromFile: XCTestCase.stubPath(for: "AppNewsMock_notCompliant_badDateFormat", ofType: "json", inBundleOf: AppNewsListViewModelTests.self))

        // When
        viewModel.load()
        let state = viewModel.releaseDescriptions

        // Then
        switch state {
        case let .error(error):
            XCTAssertTrue(error == AppNewsListViewModel.Error.jsonParsingFailure, "Supposed to have an AppNewsListViewModel.Error.jsonParsingFailure instead of \(error)")
        default:
            XCTFail("Supposed to have an AppNewsListViewModel.Error.jsonParsingFailure")
        }
    }

    func testAppNewsListViewModel_load_suitableFile() {
        // Given
        let jsonRawRelease1 = """
                {
                    "version": "0.15.0",
                    "date": "2023-11-14",
                    "news": "Add internationalization support."
                }
        """
        let expectedRelease1 = decode(from: jsonRawRelease1)!

        let jsonRawRelease2 = """
                {
                    "version": "0.14.0",
                    "date": "2023-10-09",
                    "news": "Update some API ᕙ(`▿´)ᕗ"
                }
        """
        let expectedRelease2 = decode(from: jsonRawRelease2)!

        let jsonRawRelease3 = """
                {
                    "version": "0.13.1",
                    "date": "2023-09-13",
                    "news": "Add more ✨ in your tests"
                }
        """
        let expectedRelease3 = decode(from: jsonRawRelease3)!

        // AppNewsMock.json must match the objects above of coruse
        let viewModel = AppNewsListViewModel(fromFile: XCTestCase.stubPath(for: "AppNewsMock", ofType: "json", inBundleOf: AppNewsListViewModelTests.self))

        // When
        viewModel.load()
        let state = viewModel.releaseDescriptions

        // Then
        switch state {
        case let .loaded(releaseDescription):
            XCTAssertTrue(releaseDescription.count == 3)
            XCTAssertEqual(expectedRelease1.version, releaseDescription[0].version)
            XCTAssertEqual(expectedRelease1.date, releaseDescription[0].date)
            XCTAssertEqual(expectedRelease1.news, releaseDescription[0].news)
            XCTAssertEqual(expectedRelease2.version, releaseDescription[1].version)
            XCTAssertEqual(expectedRelease2.date, releaseDescription[1].date)
            XCTAssertEqual(expectedRelease2.news, releaseDescription[1].news)
            XCTAssertEqual(expectedRelease3.version, releaseDescription[2].version)
            XCTAssertEqual(expectedRelease3.date, releaseDescription[2].date)
            XCTAssertEqual(expectedRelease3.news, releaseDescription[2].news)
        default:
            XCTFail("Supposed to have some payload, not loading nor error state")
        }
    }

    private func decode(from rawJSON: String) -> AboutReleaseDescription? {
        let dateFormatter = DateFormatter.formatter(for: "yyyy-MM-dd")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        guard let decodedRelease = try? decoder.decode(AboutReleaseDescription.self, from: Data(rawJSON.utf8)) else {
            fatalError("Not possible to decoded raw JSON for tests")
        }
        return decodedRelease
    }
}
