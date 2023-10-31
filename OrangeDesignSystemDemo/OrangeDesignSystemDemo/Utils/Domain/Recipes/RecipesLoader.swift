//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

class RecipeLoader {

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
