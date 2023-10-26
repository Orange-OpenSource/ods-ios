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

/// Show the List style and the Header and Footer of Section. It also
/// illustrates the editong mode to remove or move items into the list.
///
/// 6 types of style are available:
/// - automatic
/// - insetGrouped
/// - grouped
/// - inset
/// - plain
/// - sidebar
///
/// As mentioned earlier, SwiftUI will use Inset Grouped style when setting automatic (.automatic) or DefaultListStyle on iOS
///
struct ListModule: View {

    // =======================
    // MARK: Stored Properties
    // =======================
    
    private let optionModel: ListModuleOptionsModel
    private let dataModel: ListModuleDataModel

    // =================
    // MARK: Initializer
    // =================

    init() {
        self.optionModel = ListModuleOptionsModel()
        self.dataModel = ListModuleDataModel()
    }

    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        CustomizableVariant {
            ListModuleInner(optionModel: optionModel, dataModel: dataModel)
        } options: {
            ListModuleOptions(model: optionModel)
        }
    }
}

private struct ListModuleInner: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    @Environment(\.editMode) private var editMode
    @ObservedObject var optionModel: ListModuleOptionsModel
    @ObservedObject var dataModel: ListModuleDataModel
    @State private var foodsSectionExpanded: Bool = true // for ios > 17
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        List {
            // The recipes section with header and footer according to options
            Section {
                ForEach(dataModel.filtedReceipes, id:\.title) { recipe in
                    listItem(for: recipe).odsListItemStyle()
                }
                .onMove(perform: dataModel.moveRecipe)
                .onDelete(perform: dataModel.deleteRecipe)
            } header: {
                if optionModel.showHeader {
                    Text("Recipes")
                }
            } footer: {
                if optionModel.showFooter {
                    Text("All the recipes are made with selected ingredients.")
                        .odsFont(.caption2)
                }
            }
            
            // The Foods section with expandable style for ios17
            if #available(iOS 17.0, *) {
                Section("Foods", isExpanded: $foodsSectionExpanded) {
                    foodSectionContent
                }
            } else {
                Section("Foods") {
                    foodSectionContent
                }
            }
        }
        .toolbar {
            if optionModel.isEditable {
                EditButton()
            }
        }
        .modifier(ListStyleModifier(styleOption: optionModel.listStyleOption))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            dataModel.resetAll()
        }
    }
    
    // =====================
    // MARK: Private helpers
    // =====================

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
    
    private var foodSectionContent: some View {
        ForEach(dataModel.selectedFoods, id:\.name) { food in
            listItem(for: food).odsListItemStyle()
        }
        .onDelete(perform: dataModel.deleteFood)
        .onMove(perform: dataModel.moveFood)
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

