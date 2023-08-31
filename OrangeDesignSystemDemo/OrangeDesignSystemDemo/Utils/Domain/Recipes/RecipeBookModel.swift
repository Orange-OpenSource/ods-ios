//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
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
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let imageString = try container.decode(String.self, forKey: .image)
        self.image = URL(string: imageString)
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
        
        self.recipes = recipesDto.map { Recipe(from: $0, using: foods) }
        self.foods = foods
    }
    
    enum CodingKeys: CodingKey {
        case recipes
        case foods
    }
}

extension Recipe {
    init(from dto: RecipeDTO, using foods: [Food]) {
        
        self.title = dto.title
        self.subtitle = dto.subtitle
        self.description = dto.description
        self.url = dto.url
        self.iconName = dto.iconName
        
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
        self.quantity = dto.quantity
    }
}
