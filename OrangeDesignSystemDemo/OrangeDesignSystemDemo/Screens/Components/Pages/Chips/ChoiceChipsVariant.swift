//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

final class ChoiceChipVariantModel: ObservableObject {
    @Published var showEnabled: Bool = true
}

struct ChoiceChipVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject private var model: ChoiceChipVariantModel
    @State private var isSelected: Bool = false
    @State private var selectedFood: Food
    private let foods: [Food]

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
                VStack(alignment: .leading, spacing: ODSSpacing.m) {
                    Text("screens.components.chips.choice.description")
                        .padding(.horizontal, ODSSpacing.m)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ODSChoiceChipPicker(
                        chips: foods.map { .init(text: Text($0.name), value: $0) },
                        selection: $selectedFood,
                        placement: .stacked)
                        .disabled(!model.showEnabled)
                }
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
