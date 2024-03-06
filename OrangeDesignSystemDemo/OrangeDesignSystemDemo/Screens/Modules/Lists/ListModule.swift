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

/// Show the List style and the Header and Footer of Section. It also
/// illustrates the editing mode to remove or move items into the list.
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
        optionModel = ListModuleOptionsModel()
        dataModel = ListModuleDataModel()
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

    @ObservedObject var optionModel: ListModuleOptionsModel
    @ObservedObject var dataModel: ListModuleDataModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List {
            // The recipes section with header and footer according to options
            Section {
                ForEach(dataModel.filteredReceipes, id: \.title) { recipe in
                    listItem(for: recipe).odsListItemStyle()
                }
                .onMove(perform: dataModel.moveRecipe)
                .onDelete(perform: dataModel.deleteRecipe)
            } header: {
                if optionModel.showHeader {
                    Text("shared.recipes")
                }
            } footer: {
                if optionModel.showFooter {
                    Text("screens.modules.lists.section.footer.text")
                        .odsFont(.labelS)
                }
            }

            Section("shared.foods") {
                ForEach(dataModel.selectedFoods, id: \.name) { food in
                    listItem(for: food).odsListItemStyle()
                }
                .onDelete(perform: dataModel.deleteFood)
                .onMove(perform: dataModel.moveFood)
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
            title: Text(recipe.title),
            subtitle: Text(recipe.subtitle),
            leading: .circularImage(source: .asyncImage(recipe.url, Image("placeholder", bundle: Bundle.ods))))
    }

    @ViewBuilder
    private func listItem(for food: Food) -> some View {
        let defaultImage = Image("placeholder", bundle: Bundle.ods)
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
