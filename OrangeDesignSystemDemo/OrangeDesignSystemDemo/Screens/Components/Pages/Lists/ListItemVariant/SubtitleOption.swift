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

enum SubtitleOption: Int, CaseIterable {
    case none
    case oneLine
    case twoLines

    var description: LocalizedStringKey {
        switch self {
        case .none:
            return "screens.components.lists.subtitle_option.none"
        case .oneLine:
            return "screens.components.lists.subtitle_option.one_line"
        case .twoLines:
            return "screens.components.lists.subtitle_option.two_lines"
        }
    }

    var chip: ODSChoiceChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var chips: [ODSChoiceChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}
