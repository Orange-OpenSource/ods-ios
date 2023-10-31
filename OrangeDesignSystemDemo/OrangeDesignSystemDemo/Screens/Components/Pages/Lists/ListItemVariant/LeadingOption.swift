//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem

// =============
// MARK: Options
// =============

enum LeadingOption: Int, CaseIterable {
    case none
    case icon
    case circle
    case wide
    case square

    var description: String {
        switch self {
        case .none:
            return °°"shared.none"
        case .icon:
            return °°"shared.icon"
        case .circle:
            return °°"shared.circle"
        case .wide:
            return °°"shared.wide"
        case .square:
            return °°"shared.square"
        }
    }

    var chip: ODSChip<Self> {
        ODSChip(self, text: description)
    }

    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}
