//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

class InputChipVariantModel: ObservableObject {

    @Published var showEnabled: Bool = true
    @Published var leadingElement: LeadingElement = .none

    enum LeadingElement: Int, CaseIterable, Hashable {
        case none
        case avatar
        case icon

        var description: String {

            switch self {
            case .none: return "None"
            case .avatar: return "Avatar"
            case .icon: return "Icon"
            }
        }
    }
}

struct InputChipVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject private var model: InputChipVariantModel
    @State private var showText: String?
    private let food: Food

    // =================
    // MARK: Initializer
    // =================

    init(model: InputChipVariantModel) {
        self.model = model
        food = RecipeBook.shared.foods[0]
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            Toastable(showText: $showText) {
                ScrollView {
                    HStack {
                        ODSInputChip(
                            text: Text(food.name),
                            avatarSource: avatarSource(for: food),
                            action: {
                                showText = "screens.components.chips.variant.chip.clicked".localized(with: food.name)
                            },
                            removeAction: {
                                showText = "screens.components.chips.variant.input.remove_clicked".🌐
                            })
                            .disabled(!model.showEnabled)

                        Spacer()
                    }
                }
            }
            .padding(.all, ODSSpacing.m)
        } options: {
            InputChipVariantOptions(model: model)
        }
    }

    func avatarSource(for food: Food) -> ODSImage.Source? {
        if model.leadingElement == .avatar, let url = food.image {
            return ODSImage.Source(url: url)
        }

        if model.leadingElement == .icon {
            return .image(Image("Restaurant"))
        }

        return nil
    }
}

struct InputChipVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: InputChipVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            ChipPickerContainer(
                title: Text("shared.leading"),
                placement: .carousel,
                values: InputChipVariantModel.LeadingElement.allCases)
            {
                chip(for: $0)
            }

            Toggle("shared.enabled", isOn: $model.showEnabled)
                .padding(.horizontal, ODSSpacing.m)
        }
        .padding(.vertical, ODSSpacing.s)
        .odsFont(.bodyBold)
    }

    func chip(for leadingElement: InputChipVariantModel.LeadingElement) -> some View {
        ODSChoiceChip(text: Text(leadingElement.description), isSelected: leadingElement == model.leadingElement) {
            model.leadingElement = leadingElement
        }
    }
}
