//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

final class InputChipVariantModel: ObservableObject {

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
                    VStack(alignment: .leading, spacing: ODSSpacing.m) {
                        Text("screens.components.chips.input.description")
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ODSInputChip(
                            text: Text(food.name),
                            leading: leading(for: food),
                            action: {
                                showText = "screens.components.chips.variant.chip.clicked".localized(with: food.name)
                            },
                            removeAction: {
                                showText = "screens.components.chips.variant.input.remove_clicked".🌐
                            })
                            .disabled(!model.showEnabled)
                    }
                }
                .padding(.all, ODSSpacing.m)
            }
        } options: {
            InputChipVariantOptions(model: model)
        }
    }

    func leading(for food: Food) -> ODSImage.Source? {
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
    let leadingElement = InputChipVariantModel.LeadingElement.allCases

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {

            ODSChoiceChipPicker(
                title: Text("shared.leading"),
                chips: leadingElement.map {
                    .init(text: Text($0.description), value: $0)
                },
                selection: $model.leadingElement,
                placement: .carousel)

            Toggle("shared.enabled", isOn: $model.showEnabled)
                .padding(.horizontal, ODSSpacing.m)
        }
        .padding(.vertical, ODSSpacing.s)
        .odsFont(.bodyLBold)
    }
}
