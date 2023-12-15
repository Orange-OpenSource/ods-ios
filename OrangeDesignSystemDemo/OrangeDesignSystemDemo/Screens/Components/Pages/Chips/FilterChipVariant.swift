//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

class FilterChipVariantModel: ObservableObject {

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

        var chip: ODSChoiceChip<Self> {
            .init(text: Text(description), value: self)
        }

        static var chips: [ODSChoiceChip<Self>] {
            Self.allCases.map { $0.chip }
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
        .odsFont(.bodyBold)
        .padding(.vertical, ODSSpacing.s)
    }
}
