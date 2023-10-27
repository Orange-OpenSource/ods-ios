/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// =============
// MARK: Models
// =============


enum StandardTrailingOption: CaseIterable {
    case text
    case iButton
    
    var description: String {
        switch self {
        case .text:
            return °°"shared.text"
        case .iButton:
            return °°"screens.guidelines.lists.options.description.info_button"
        }
    }
    
    private var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
        
    static var chips: [ODSChip<Self>] {
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
