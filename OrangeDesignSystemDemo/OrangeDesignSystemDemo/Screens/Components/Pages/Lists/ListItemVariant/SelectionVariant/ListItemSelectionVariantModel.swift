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

    private var chip: ODSChoiceChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var chips: [ODSChoiceChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

final class ListItemSelectionVariantModel: ObservableObject {

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
