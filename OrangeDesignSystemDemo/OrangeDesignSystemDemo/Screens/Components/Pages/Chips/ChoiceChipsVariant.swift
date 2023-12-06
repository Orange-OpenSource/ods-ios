//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

class ChoiceChipVariantModel: ObservableObject {
    @Published var showEnabled: Bool = true
}

struct ChoiceChipVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @State var isSelected: Bool = false
    @ObservedObject var model: ChoiceChipVariantModel
    @State var selectedFood: Food
    let foods: [Food]

    // =================
    // MARK: Initializer
    // =================

    init(model: ChoiceChipVariantModel) {
        self.model = model
        foods = Array(RecipeBook.shared.foods.prefix(6))
        _selectedFood = State(initialValue: foods.first!)
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ScrollView {
                ChipPickerContainer(title: nil, placement: .stacked, values: foods) { food in
                    ODSChoiceChip(text: Text(food.name), isSelected: food == selectedFood) {
                        selectedFood = food
                    }
                }
                .disabled(!model.showEnabled)
                .padding(.vertical, ODSSpacing.m)
            }
        } options: {
            ChoiceChipVariantOptions(model: model)
        }
    }
}

struct ChoiceChipVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: ChoiceChipVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            Toggle("shared.enabled", isOn: $model.showEnabled)
        }
        .odsFont(.bodyBold)
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}
