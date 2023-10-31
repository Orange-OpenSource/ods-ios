//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import SwiftUI

// MARK: RecipeBook model

struct RecipeBook {
    let recipes: [Recipe]
    let foods: [Food]

    static let shared: RecipeBook = .init()
}

struct Food: Equatable {
    let id: Int
    let name: String
    let image: URL?
}

struct Recipe {
    let title: String
    let subtitle: String
    let description: String
    var ingredients: [Ingredient]
    let url: URL
    let iconName: String
}

struct Ingredient: Decodable {
    let food: Food
    let quantity: String
}
