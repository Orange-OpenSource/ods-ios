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

        var description: String {

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
        foods = Array(RecipeBook.shared.foods.prefix(3))
        selectedFoods = Array(RecipeBook.shared.foods.prefix(1))
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ScrollView {
                ChipPickerContainer(placement: .stacked, values: foods) { food in
                    chip(for: food)
                }
                .disabled(!model.showEnabled)
            }
            .padding(.top, ODSSpacing.m)
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

    func chip(for food: Food) -> some View {
        let index = selectedFoods.firstIndex(of: food)

        return ODSFilterChip(
            text: Text(food.name),
            avatarSource: leading(for: food),
            isSelected: index == nil)
        {
            if let index = index {
                selectedFoods.remove(at: index)
            } else {
                selectedFoods.append(food)
            }
        }
    }
}

struct FilterChipVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: FilterChipVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            ChipPickerContainer(
                title: Text("shared.leading"),
                placement: .carousel,
                values: FilterChipVariantModel.LeadingElement.allCases)
            { leadingElement in
                ODSChoiceChip(text: Text(leadingElement.description), isSelected: model.leadingElement == leadingElement) {
                    model.leadingElement = leadingElement
                }
            }

            Toggle("shared.enabled", isOn: $model.showEnabled)
                .padding(.horizontal, ODSSpacing.m)
        }
        .odsFont(.bodyBold)
        .padding(.vertical, ODSSpacing.s)
    }
}
