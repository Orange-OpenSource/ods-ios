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
// MARK: Options
// =============

enum LeadingOption: Int, CaseIterable {
    case none = 0
    case icon = 1
    case circle = 2
    case wide = 3
    case square = 4
    case appIcon = 10 // To be sure is the last in chips list

    var description: LocalizedStringKey {
        switch self {
        case .none:
            return "shared.none"
        case .icon:
            return "shared.icon"
        case .appIcon:
            return "shared.appIcon"
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
