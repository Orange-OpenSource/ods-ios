//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

final class ListModuleDataModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    var selectedFoods: [Food] {
        didSet { updateRecipes() }
    }

    @Published var filteredReceipes: [Recipe]

    // =================
    // MARK: Initializer
    // =================

    init() {
        selectedFoods = []
        filteredReceipes = []

        resetAll()
    }

    private func updateRecipes() {
        filteredReceipes = filteredReceipes.filter { recipe in recipe.contains(foods: selectedFoods) }
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
        filteredReceipes.remove(atOffsets: offsets)
    }

    func moveRecipe(from source: IndexSet, to destination: Int) {
        filteredReceipes.move(fromOffsets: source, toOffset: destination)
    }

    func resetAll() {
        filteredReceipes = RecipeBook.shared.recipes
        selectedFoods = Array(RecipeBook.shared.foods.prefix(3))
    }
}
