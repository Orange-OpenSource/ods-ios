//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

struct IngredientDTO: Decodable {
    let foodId: Int
    let quantity: String
}

struct RecipeDTO: Decodable {
    let title: String
    let subtitle: String
    let description: String
    var ingredients: [IngredientDTO]
    let url: URL
    let iconName: String
}

extension Food: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let imageString = try container.decode(String.self, forKey: .image)
        image = URL(string: imageString)
    }

    enum CodingKeys: CodingKey {
        case id
        case name
        case image
    }
}

extension RecipeBook: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let foods = try container.decode([Food].self, forKey: .foods)

        let recipesDto = try container.decode([RecipeDTO].self, forKey: .recipes)

        recipes = recipesDto.map { Recipe(from: $0, using: foods) }
        self.foods = foods
    }

    enum CodingKeys: CodingKey {
        case recipes
        case foods
    }
}

extension Recipe {
    init(from dto: RecipeDTO, using foods: [Food]) {

        title = dto.title
        subtitle = dto.subtitle
        description = dto.description
        url = dto.url
        iconName = dto.iconName

        let ingredients = dto.ingredients.map {
            Ingredient(from: $0, using: foods)
        }

        self.ingredients = ingredients
    }
}

extension Ingredient {
    init(from dto: IngredientDTO, using foods: [Food]) {
        let food = foods.first(where: { $0.id == dto.foodId })!
        self.food = food
        quantity = dto.quantity
    }
}
