//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public struct ODSFilterChipPcicker<Value>: View where Value: Hashable {

    // ========================
    // MARK: Internal Properties
    // ========================

    public struct Element: Hashable {
        fileprivate let text: Text
        fileprivate let avatarSource: ODSImage.Source?
        fileprivate let value: Value

        public init(text: Text, avatarSource: ODSImage.Source? = nil, value: Value) {
            self.text = text
            self.avatarSource = avatarSource
            self.value = value
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(value)
        }

        public static func == (lhs: ODSFilterChipPcicker<Value>.Element, rhs: ODSFilterChipPcicker<Value>.Element) -> Bool {
            lhs.value == rhs.value
        }
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: Text?
    private let elements: [Element]
    private var selection: Binding<[Value]>
    private let placement: ODSChipPickerPlacement

    // =================
    // MARK: Initialzier
    // =================

    public init(title: Text? = nil, elements: [Element], selection: Binding<[Value]>, placement: ODSChipPickerPlacement = .stacked) {
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
            let index = selection.wrappedValue.firstIndex(of: element.value)

            ODSFilterChip(text: element.text, avatarSource: element.avatarSource, isSelected: index == nil) {
                if let index = index {
                    selection.wrappedValue.remove(at: index)
                } else {
                    selection.wrappedValue.append(element.value)
                }
            }
        }
    }
}
