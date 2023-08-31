//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

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
            return "Title"
        case.large:
            return "Large Title"
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
            Action.showAlert(iconName: "square.and.pencil", actionText: "Edit action"),
            Action.showAlert(iconName: "square.and.arrow.up", actionText: "Share action"),
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
            case .standard: return "Standard"
            case .large: return "Large"
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
            ODSChipPicker(title: "Size",
                          selection: $model.titleSize,
                          chips: NavigationBarVariantModel.TitleSize.chips)
            Group {
                Toggle("Back button", isOn: $model.showBackButton)

                Stepper("Action icon count: \(model.actionIconCount)",
                        value: $model.actionIconCount,
                        in: 0 ... model.numberOfActions)

                Toggle("Search", isOn: $model.showSearch)
            }
            .padding(.horizontal, ODSSpacing.m)
            .odsFont(.bodyBold)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}
