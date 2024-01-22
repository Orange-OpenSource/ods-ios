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

final class RecipeLoader {

    // =================
    // MARK: Initializer
    // =================

    init() {}

    enum Error: Swift.Error {
        case resourceNotFound
        case noJsonData
    }

    // ====================
    // MARK: Private Helper
    // ====================

    func loadBook(from fileName: String) throws -> RecipeBook {

        guard let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
            throw Error.resourceNotFound
        }

        guard let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) else {
            throw Error.noJsonData
        }

        return try JSONDecoder().decode(RecipeBook.self, from: jsonData)
    }
}

extension RecipeBook {
    init() {
        guard let book = try? RecipeLoader().loadBook(from: "Recipes") else {
            recipes = []
            foods = []
            return
        }

        self = book
    }
}
