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

    @State var selectedRecipe: Recipe? = RecipesListSelection.receipes.first
    @State var isOpen: Bool = false

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        pageContent
            .odsBottomSheetStandard(isOpen: $isOpen,
                                    title: °°"screens.components.bottom_sheets.sample.recipe",
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
