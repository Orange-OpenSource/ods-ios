//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

enum ListStyleOption: Int, CaseIterable {
    case plain
    case grouped
    case inset
    case insetGrouped
    case sidebar

    var description: String {
        switch self {
        case .plain:
            return "Plain"
        case .grouped:
            return "Grouped"
        case .inset:
            return "Inset"
        case .insetGrouped:
            return "InsetGrouped"
        case .sidebar:
            return "Sidebar"
        }
    }

    var chip: ODSChip<Self> {
        ODSChip(self, text: description)
    }

    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

class ListModuleOptionsModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showHeader: Bool
    @Published var showFooter: Bool
    @Published var listStyleOption: ListStyleOption
    @Published var isEditable: Bool

    // ==================
    // MARK: Initializers
    // ==================
    init() {
        showHeader = true
        showFooter = true
        listStyleOption = .inset
        isEditable = false
    }
}
