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

// =============
// MARK: Models
// =============

enum StandardTrailingOption: CaseIterable {
    case text
    case iButton

    var description: LocalizedStringKey {
        switch self {
        case .text:
            return "shared.text"
        case .iButton:
            return "screens.components.lists.options.description.info_button"
        }
    }

    private var chip: ODSFilterChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var chips: [ODSFilterChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

class ListItemStandardVariantModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showSubtitle: Bool
    @Published var leadingOption: LeadingOption
    @Published var trailingOptions: [StandardTrailingOption]
    @Published var navigate: Bool

    // ==================
    // MARK: Initializers
    // ==================
    init() {
        showSubtitle = true
        leadingOption = .circle
        trailingOptions = []
        navigate = true
    }
}
