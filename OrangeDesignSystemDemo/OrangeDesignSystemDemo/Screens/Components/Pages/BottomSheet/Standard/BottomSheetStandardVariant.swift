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

import OrangeDesignSystem
import SwiftUI

struct StandardBottomSheetVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @State var selectedRecipe: Recipe?
    @State var isOpen: Bool
    private let recipes: [Recipe]
    
    init() {
        let recipes = Array(RecipeBook.shared.recipes.prefix(4))
        self.recipes = recipes
        self._isOpen = State(initialValue: false)
        self._selectedRecipe = State(initialValue: recipes.first)
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        pageContent
            .odsBottomSheetStandard(isOpen: $isOpen,
                                    title: °°"screens.components.bottom_sheets.sample.recipe",
                                    accessibilityStateLabels: (opened: °°"screens.components.template.customize.label.opened",
                                                               closed: °°"screens.components.template.customize.label.closed"),
                                    accessibilityStateHints: (opened: °°"screens.components.template.customize.hint.opened",
                                                              closed: °°"screens.components.template.customize.hint.closed"),
                                    icon: Image(systemName: "chevron.down")) {
                RecipesListSelection(recipes: recipes, selectedRecipe: $selectedRecipe)
            }
    }

    // ============
    // MARK: Helper
    // ============

    @ViewBuilder
    private var pageContent: some View {
        if let recipe = selectedRecipe {
            ScrollView {
                ODSCardVerticalImageFirst(
                    title: Text(recipe.title),
                    imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                    subtitle: Text(recipe.subtitle),
                    text: Text(recipe.description))
                {
                    Button("screens.components.bottom_sheets.sample.start_preparing") {}
                }
            }
        } else {
            EmptyView()
        }
    }
}

struct RecipesListSelection: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let selectedRecipe: Binding<Recipe?>
    private let recipes: [Recipe]

    // =================
    // MARK: Initializer
    // =================

    init(recipes: [Recipe], selectedRecipe: Binding<Recipe?>) {
        self.recipes = recipes
        self.selectedRecipe = selectedRecipe
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: 0) {
            ForEach(recipes, id: \.id) { recipe in
                ODSListItem(title: Text(recipe.title), leading: .icon(Image(recipe.iconName)))
                    .odsListItemStyle()
                    .onTapGesture {
                        selectedRecipe.wrappedValue = recipes.first { $0.title == recipe.title }
                    }
            }
        }
    }
}
