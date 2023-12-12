//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

enum SelectionTrailingOption: CaseIterable {
    case toggle
    case checkmark

    var description: LocalizedStringKey {
        switch self {
        case .toggle:
            return "screens.components.lists.selection.description.switch"
        case .checkmark:
            return "screens.components.lists.selection.description.checkmark"
        }
    }

    private var element: ODSChoiceChipPicker<Self>.Element {
        .init(text: Text(description), value: self)
    }

    static var elements: [ODSChoiceChipPicker<Self>.Element] {
        Self.allCases.map { $0.element }
    }
}

class ListItemSelectionVariantModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showSubtitle: Bool
    @Published var leadingOption: LeadingOption
    @Published var trailingOption: SelectionTrailingOption

    // ==================
    // MARK: Initializers
    // ==================
    init() {
        showSubtitle = true
        leadingOption = .circle
        trailingOption = .toggle
    }
}
