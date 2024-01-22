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
import SwiftUI

// MARK: RecipeBook model

struct RecipeBook {
    let recipes: [Recipe]
    let foods: [Food]

    static let shared: RecipeBook = .init()
}

struct Food: Equatable, Hashable {
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
