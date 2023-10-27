/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct StandardBottomSheetVariant: View {
    
    // =======================
    // MARK: Stored properties
    // =======================

    @State var selectedRecipe: Recipe? = RecipesListSelection.receipes.first
    @State var isOpen: Bool = false
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        pageContent
            .odsBottomSheetStandard(isOpen: $isOpen,
                                    title: °°"screens.guidelines.bottom_sheets.sample.recipe",
                                    icon: Image(systemName: "chevron.down")) {
                RecipesListSelection(selectedRecipe: $selectedRecipe)
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
                    text: Text(recipe.description)) {
                        Button("screens.guidelines.bottom_sheets.sample.start_preparing") {}
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
    fileprivate static let receipes: [Recipe] = Array(RecipeBook.shared.recipes.prefix(4))
    
    // =================
    // MARK: Initializer
    // =================

    init(selectedRecipe: Binding<Recipe?>) {
        self.selectedRecipe = selectedRecipe
        self.selectedRecipe.wrappedValue = Self.receipes.first
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Self.receipes, id: \.id) { recipe in
                ODSListItem(title: Text(recipe.title), leading: .icon(Image(recipe.iconName)))
                    .odsListItemStyle()
                    .onTapGesture {
                        selectedRecipe.wrappedValue = Self.receipes.first { $0.title == recipe.title }
                    }
            }
        }
    }
}
