//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

// =============
// MARK: Options
// =============

enum LeadingOption: Int, CaseIterable {
    case none
    case icon
    case circle
    case wide
    case square

    var description: LocalizedStringKey {
        switch self {
        case .none:
            return "shared.none"
        case .icon:
            return "shared.icon"
        case .circle:
            return "shared.circle"
        case .wide:
            return "shared.wide"
        case .square:
            return "shared.square"
        }
    }

    var chip: ODSChoiceChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var chips: [ODSChoiceChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}
