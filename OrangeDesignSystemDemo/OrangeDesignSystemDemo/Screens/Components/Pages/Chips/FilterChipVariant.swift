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

    @ObservedObject var model: FilterChipVariantModel
    @State var selectedFoods: [Food]
    let foods: [Food]

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
                FilterChipPicker(selection: $selectedFoods, elements: foods.map { filterChipElement(for: $0) })
                    .disabled(!model.showEnabled)
            }
            .padding(.top, ODSSpacing.m)
        } options: {
            FilterChipVariantOptions(model: model)
        }
    }

    func filterChipElement(for food: Food) -> FilterChipPicker<Food>.Element {
        if model.leadingElement == .avatar, let url = food.image {
            return FilterChipPicker.Element(value: food, text: Text(food.name), avatar: ODSImage.Source(url: url))
        } else {
            return FilterChipPicker.Element(value: food, text: Text(food.name), avatar: nil)
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
        VStack {
            Text("Leading Element").frame(maxWidth: .infinity, alignment: .leading)
            ChoisceChipPicker(
                selection: $model.leadingElement,
                elements: FilterChipVariantModel.LeadingElement.allCases.map {
                    .init(value: $0, text: Text($0.description))
                })

            Toggle("shared.enabled", isOn: $model.showEnabled)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}

struct FilterChipPicker<Value>: View where Value: Hashable {

    // ===========
    // MARK: Types
    // ===========

    public struct Element {
        fileprivate let value: Value
        fileprivate let text: Text
        fileprivate let avatar: ODSImage.Source?

        public init(value: Value, text: Text, avatar: ODSImage.Source? = nil) {
            self.value = value
            self.text = text
            self.avatar = avatar
        }
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    @Binding var selection: [Value]
    let elements: [Element]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: ODSSpacing.m) {
                ForEach(elements, id: \.value) { element in
                    let index = selection.firstIndex(of: element.value)

                    ODSFilterChip(text: element.text, avatarSource: element.avatar, isSelected: index == nil) {
                        if let index = index {
                            selection.remove(at: index)
                        } else {
                            selection.append(element.value)
                        }
                    }
                }
            }
            .padding(.leading, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
    }
}
