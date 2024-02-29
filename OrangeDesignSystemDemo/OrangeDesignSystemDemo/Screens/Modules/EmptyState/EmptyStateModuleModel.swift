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

import SwiftUI
import OrangeDesignSystem

final class EmptyStateModuleModel: ObservableObject {
    
    // =========================
    // MARK: - Stored properties
    // =========================

    @Published var usageOption: UsageOption
    @Published var showButton: Bool
    @Published var showSubtitle: Bool

    // ===================
    // MARK: - Initializer
    // ===================

    init() {
        usageOption = .firstUse
        showButton = true
        showSubtitle = true
    }

    // ====================
    // MARK: - Usage Option
    // ====================

    enum UsageOption: Int, CaseIterable {
        case firstUse = 0
        case userCleared
        case error
        case noData
        
        var description: LocalizedStringKey {
            switch self {
            case .firstUse:
                return "screens.modules.empty_state.usage_first_use.choice"
            case .userCleared:
                return "screens.modules.empty_state.usage_user_cleared.choice"
            case .error:
                return "screens.modules.empty_state.usage_error.choice"
            case .noData:
                return "screens.modules.empty_state.usage_no_data.choice"
            }
        }
        
        var chip: ODSChoiceChip<Self> {
            .init(text: Text(description), value: self)
        }
        
        static var chips: [ODSChoiceChip<Self>] {
            Self.allCases.map { $0.chip }
        }
        
        var title: Text {
            switch self {
            case .firstUse:
                return Text("screens.modules.empty_state.usage_first_use.title")
            case .noData:
                return Text("screens.modules.empty_state.usage_no_data.title")
            case .userCleared:
                return Text("screens.modules.empty_state.usage_user_cleared.title")
            case .error:
                return Text("screens.modules.empty_state.usage_error.title")
            }
        }
        
        var text: Text {
            switch self {
            case .firstUse:
                return Text("screens.modules.empty_state.usage_first_use.text")
            case .noData:
                return Text("screens.modules.empty_state.usage_no_data.text")
            case .userCleared:
                return Text("screens.modules.empty_state.usage_user_cleared.text")
            case .error:
                return Text("screens.modules.empty_state.usage_error.text")
            }
        }
        
        var buttonLabel: String {
            switch self {
            case .firstUse:
                return "screens.modules.empty_state.usage_first_use.buttonLabel".🌐
            case .noData:
                return "screens.modules.empty_state.usage_no_data.buttonLabel".🌐
            case .userCleared:
                return "screens.modules.empty_state.usage_user_cleared.buttonLabel".🌐
            case .error:
                return "screens.modules.empty_state.usage_error.buttonLabel".🌐
            }
        }
        
        var imageName: String? {
            switch self {
            case .firstUse:
                return "il_emptyStateFirstUse"
            case .noData:
                return "il_emptyStateNoData"
            case .userCleared:
                return nil
            case .error:
                return "il_emptyStateError"
            }
        }
    }
}
