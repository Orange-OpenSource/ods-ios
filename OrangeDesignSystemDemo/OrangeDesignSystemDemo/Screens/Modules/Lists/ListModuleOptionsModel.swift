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

    var description: LocalizedStringKey {
        switch self {
        case .plain:
            return "screens.modules.lists.options.style.plain"
        case .grouped:
            return "screens.modules.lists.options.style.grouped"
        case .inset:
            return "screens.modules.lists.options.style.inset"
        case .insetGrouped:
            return "screens.modules.lists.options.style.insetGrouped"
        case .sidebar:
            return "screens.modules.lists.options.style.sidebar"
        }
    }

    var chip: ODSChoiceChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var elemnts: [ODSChoiceChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

final class ListModuleOptionsModel: ObservableObject {

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
