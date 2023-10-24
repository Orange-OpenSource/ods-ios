/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct NavigationBarVariantContent: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject var model: NavigationBarVariantModel
    let searchModel = NavigationBarSearchModel()

    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        ListExample(model: searchModel)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(model.titleSize.displayMode)
            .modifier(SearchModifier(showSearch: model.showSearch, model: searchModel))
            .modifier(ActionIconsModifier(model: model))
            .navigationBarBackButtonHidden(!model.showBackButton)
    }

    // ============
    // MARK: Helper
    // ============
    
    private var title: String {
        switch model.titleSize {
        case .standard:
            return "screens.guidelines.bars.navigation.standard_title.text".🌐
        case .large:
            return "screens.guidelines.bars.navigation.large_title.text".🌐
        }
    }
}

class NavigationBarVariantModel: ObservableObject {

    // ======================
    // MARK: Store properties
    // ======================

    @Published var titleSize: TitleSize
    @Published var showSearch: Bool
    @Published var actionIconCount: Int
    @Published var showBackButton: Bool
    private let actions: [Action]

    // ==================
    // MARK: Initializers
    // ==================

    init() {
        titleSize = .large
        showSearch = false
        actionIconCount = 0
        showBackButton = true
        actions = [
            Action.showThemeSelection,
            Action.showAlert(iconName: "square.and.pencil", actionText: "screens.guidelines.bars.navigation.button.edit".🌐),
            Action.showAlert(iconName: "square.and.arrow.up", actionText: "screens.guidelines.bars.navigation.button.share".🌐),
        ]
    }

    // =============
    // MARK: Helpers
    // =============

    var availableActions: [Action] {
        Array(actions.prefix(actionIconCount))
    }
    
    var numberOfActions: Int {
        actions.count
    }

    // ====================
    // MARK: Internal types
    // ====================
    
    enum TitleSize: Int, CaseIterable {
        case standard
        case large

        var displayMode: NavigationBarItem.TitleDisplayMode {
            switch self {
            case .standard: return .inline
            case .large: return .large
            }
        }

        var description: String {
            switch self {
            case .standard: return "screens.guidelines.bars.navigation.standard_title.hint".🌐
            case .large: return "screens.guidelines.bars.navigation.large_title.hint".🌐
            }
        }

        var chip: ODSChip<TitleSize> {
            ODSChip(self, text: self.description)
        }

        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }
    
    enum Action: Identifiable {
        case showThemeSelection
        case showAlert(iconName: String, actionText: String)
        
        var id: String {
            switch self {
            case .showThemeSelection:
                return UUID().uuidString
            case .showAlert(let iconName, _):
                return iconName
            }
        }
    }
}

struct NavigationBarVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: NavigationBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            ODSChipPicker(title: "screens.guidelines.bars.navigation.size.hint".🌐,
                          selection: $model.titleSize,
                          chips: NavigationBarVariantModel.TitleSize.chips)
            Group {
                Toggle("screens.guidelines.bars.navigation.back_button.hint", isOn: $model.showBackButton)

                Stepper("screens.guidelines.bars.navigation.action_item_count".localized(with: ["\(model.actionIconCount)"]),
                        value: $model.actionIconCount,
                        in: 0 ... model.numberOfActions)

                Toggle("shared.search", isOn: $model.showSearch)
            }
            .padding(.horizontal, ODSSpacing.m)
            .odsFont(.bodyBold)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}
