//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

class ActionChipVariantModel: ObservableObject {
    @Published var showEnabled: Bool = true
}

struct ActionChipVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: ActionChipVariantModel
    let foods: [Food]
    @State var showText: String?

    // =================
    // MARK: Initializer
    // =================

    init(model: ActionChipVariantModel) {
        self.model = model
        foods = RecipeBook.shared.foods
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            Toastable(showText: $showText) {
                ScrollView(.vertical) {
                    ScrollView(.horizontal) {
                        HStack(spacing: ODSSpacing.m) {
                            ForEach(foods, id: \.id) { food in
                                ODSActionChip(text: Text(food.name), leadingIcon: Image("Cafe")) {
                                    showText = "screens.components.chips.variant.action.clicked".localized(with: food.name)
                                }
                            }
                            .disabled(!model.showEnabled)
                        }
                        .padding(.leading, ODSSpacing.m)
                        .padding(.vertical, ODSSpacing.s)
                    }
                }
            }
            .padding(.top, ODSSpacing.m)
        } options: {
            ActionChipVariantOptions(model: model)
        }
    }
}

struct ActionChipVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: ActionChipVariantModel

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
