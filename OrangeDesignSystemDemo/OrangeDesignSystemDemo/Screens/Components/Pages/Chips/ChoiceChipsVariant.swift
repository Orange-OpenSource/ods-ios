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
    @State var selectedFood: String
    let foods: [Food]

    // =================
    // MARK: Initializer
    // =================

    init(model: ChoiceChipVariantModel) {
        self.model = model
        foods = RecipeBook.shared.foods
        selectedFood = foods.first!.name
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ScrollView {
                ChoisceChipPicker(selection: $selectedFood, elements: [
                    .init(value: foods[0].name, text: Text(foods[0].name)),
                    .init(value: foods[1].name, text: Text(foods[1].name)),
                    .init(value: foods[2].name, text: Text(foods[2].name)),
                ])
                .disabled(!model.showEnabled)
            }
            .padding(.top, ODSSpacing.m)
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
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}

struct ChoisceChipPicker<Value>: View where Value: Hashable {

    // ===========
    // MARK: Types
    // ===========

    public struct Element {
        fileprivate let value: Value
        fileprivate let text: Text

        public init(value: Value, text: Text) {
            self.value = value
            self.text = text
        }
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    @Binding var selection: Value
    let elements: [Element]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: ODSSpacing.m) {
                ForEach(elements, id: \.value) { element in
                    ODSChoiceChip(text: element.text, isSelected: element.value == selection) {
                        selection = element.value
                    }
                }
            }
            .padding(.leading, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
    }
}
