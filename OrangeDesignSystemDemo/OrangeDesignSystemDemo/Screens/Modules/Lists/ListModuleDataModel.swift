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
