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

import OrangeDesignSystem
import SwiftUI

struct ListHeaderVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================
    
    let model: ListHeaderVariantModel
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        CustomizableVariant {
            ListHeaderVariantInner(model: model)
        } options: {
            ListHeaderVariantOptions(model: model)
        }
    }
}

private struct ListHeaderVariantInner: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ListHeaderVariantModel
    @State private var isSelected: Bool = true
    @State private var sectionExpanded: Bool = true

    // =================
    // MARK: Initializer
    // =================

    init(model: ListHeaderVariantModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========
    
    @available(iOS 17.0, *)
    var ios17Section: some View {
        Section(isExpanded: $sectionExpanded) {
            ForEach(filtedReceipes, id:\.title) { recipe in
                listItem(for: recipe).odsListItemStyle()
            }
        } header: {
            recipesHeader(suffix: "ios 17")
        }
    }
    
    var body: some View {
        List {
            Section {
                ForEach(filtedReceipes, id:\.title) { recipe in
                    listItem(for: recipe).odsListItemStyle()
                }
            } header: {
                recipesHeader()
            } footer: {
                recipesFooter
            }
            
            if #available(iOS 17.0, *) {
                ios17Section
            }
            
            Section("Foods") {
                ForEach(selectedFoods, id:\.name) { food in
                    listItem(for: food).odsListItemStyle()
                }
            }
        }
        .modifier(ListStyleModifier(styleOption: model.listStyleOption))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    // =====================
    // MARK: Private helpers
    // =====================
    
    @ViewBuilder
    func recipesHeader(suffix: String = "") -> some View {
        if model.showHeader {
            Text("Recipes \(suffix)")
        }
    }
    @ViewBuilder
    var recipesFooter: some View {
        if model.showFooter {
            Text("All the recipes are made with organic ingredients.")
        }
    }
    
    var foodHeader: some View {
        Text("Foods")
    }
    var foodsFooter: some View {
        Text("Selection of foods for you.")
    }
    
    private var selectedFoods: [Food] {
        Array(RecipeBook.shared.foods.prefix(13))
    }
    private var filtedReceipes: [Recipe] {
        RecipeBook.shared.recipes.filter { recipe in
            recipe.contains(foods: selectedFoods)
        }
    }

    @ViewBuilder
    private func listItem(for recipe: Recipe) -> some View {
        ODSListItem(
            title:  Text(recipe.title),
            subtitle: Text(recipe.subtitle),
            leading: .circularImage(source: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)))
        )
    }
    
    @ViewBuilder
    private func listItem(for food: Food) -> some View {
        let defaultImage = Image("ods_empty", bundle: Bundle.ods)
        
        if let imageUrl = food.image {
            ODSListItem(title: Text(food.name), leading: .circularImage(source: .asyncImage(imageUrl, defaultImage)))
        } else {
            ODSListItem(title: Text(food.name), leading: .circularImage(source: .image(defaultImage)))
        }
    }
}

struct ListStyleModifier: ViewModifier {
    
    let styleOption: ListStyleOption
    
    func body(content: Content) -> some View {
        switch styleOption {
        case .plain:
            content.listStyle(.plain)
        case .grouped:
            content.listStyle(.grouped)
        case .inset:
            content.listStyle(.inset)
        case .insetGrouped:
            content.listStyle(.insetGrouped)
        case .sidebar:
            content.listStyle(.sidebar)
        }
    }
}

extension Recipe {
    func contains(foods: [Food]) -> Bool {
        ingredients.contains { ingredient in
            foods.contains { $0 == ingredient.food }
        }
    }
}
