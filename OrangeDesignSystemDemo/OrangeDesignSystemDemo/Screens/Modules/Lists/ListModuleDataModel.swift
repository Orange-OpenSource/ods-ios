//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
