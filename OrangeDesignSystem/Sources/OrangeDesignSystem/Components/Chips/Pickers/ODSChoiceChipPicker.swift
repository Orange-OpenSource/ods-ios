//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSChoiceChipPicker<Value>: View where Value: Hashable {
    public struct Element: Hashable {
        let text: Text
        let value: Value

        public init(text: Text, value: Value) {
            self.text = text
            self.value = value
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: Text?
    private let elements: [Element]
    private var selection: Binding<Value>
    private let placement: ODSChipPickerPlacement

    // =================
    // MARK: Initializer
    // =================

    public init(title: Text? = nil, elements: [Element], selection: Binding<Value>, placement: ODSChipPickerPlacement = .carousel) {
        self.title = title
        self.elements = elements
        self.selection = selection
        self.placement = placement
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        ChipPickerContainer(
            title: title,
            placement: placement,
            values: elements)
        { element in
            ODSChoiceChip(text: element.text, isSelected: selection.wrappedValue == element.value) {
                selection.wrappedValue = element.value
            }
        }
    }
}
