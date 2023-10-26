////
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

import SwiftUI

class ListModuleDataModel: ObservableObject {
    
    // =======================
    // MARK: Stored properties
    // =======================

    @Published var selectedFoods: [Food] {
        didSet { updateRecipes() }
    }

    @Published var filtedReceipes: [Recipe]

    // =================
    // MARK: Initializer
    // =================

    init() {
        selectedFoods = []
        filtedReceipes = []

        resetAll()
    }

    private func updateRecipes() {
        filtedReceipes = filtedReceipes.filter { recipe in recipe.contains(foods: selectedFoods) }
    }

    //======================
    // MARK: Edition actions
    // =====================
    
    func deleteFood(at offsets: IndexSet) {
        selectedFoods.remove(atOffsets: offsets)
        updateRecipes()
    }
    func moveFood(from source: IndexSet, to destination: Int) {
        selectedFoods.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteRecipe(at offsets: IndexSet) {
        filtedReceipes.remove(atOffsets: offsets)
    }
    func moveRecipe(from source: IndexSet, to destination: Int) {
        filtedReceipes.move(fromOffsets: source, toOffset: destination)
    }
    
    func resetAll() {
        filtedReceipes = RecipeBook.shared.recipes
        selectedFoods = Array(RecipeBook.shared.foods.prefix(3))
    }
}
