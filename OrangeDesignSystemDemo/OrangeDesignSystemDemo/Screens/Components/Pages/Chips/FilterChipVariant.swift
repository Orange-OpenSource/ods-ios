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

final class FilterChipVariantModel: ObservableObject {

    @Published var showEnabled: Bool = true
    @Published var leadingElement: LeadingElement = .none

    enum LeadingElement: Int, CaseIterable, Hashable {
        case none
        case avatar

        var description: LocalizedStringKey {

            switch self {
            case .none: return "None"
            case .avatar: return "Avatar"
            }
        }
    }
}

struct FilterChipVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject private var model: FilterChipVariantModel
    @State private var selectedFoods: [Food]
    private let foods: [Food]

    // =================
    // MARK: Initializer
    // =================

    init(model: FilterChipVariantModel) {
        self.model = model
        foods = Array(RecipeBook.shared.foods.prefix(6))
        selectedFoods = Array(RecipeBook.shared.foods.prefix(1))
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ScrollView {
                VStack(alignment: .leading, spacing: ODSSpacing.m) {
                    Text("screens.components.chips.filter.description")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, ODSSpacing.m)

                    ODSFilterChipPicker(
                        chips: foods.map { food in
                            .init(text: Text(food.name), leading: leading(for: food), value: food)
                        },
                        selection: $selectedFoods)
                        .disabled(!model.showEnabled)
                }
                .padding(.top, ODSSpacing.m)
            }
        } options: {
            FilterChipVariantOptions(model: model)
        }
    }

    func leading(for food: Food) -> ODSImage.Source? {
        if model.leadingElement == .avatar, let url = food.image {
            return ODSImage.Source(url: url)
        } else {
            return nil
        }
    }
}

struct FilterChipVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: FilterChipVariantModel
    let leadingElements = FilterChipVariantModel.LeadingElement.allCases

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            ODSChoiceChipPicker(
                title: Text("shared.leading"),
                chips: leadingElements.map { .init(text: Text($0.description), value: $0) },
                selection: $model.leadingElement,
                placement: .carousel)

            Toggle("shared.enabled", isOn: $model.showEnabled)
                .padding(.horizontal, ODSSpacing.m)
        }
        .odsFont(.bodyLBold)
        .padding(.vertical, ODSSpacing.s)
    }
}
