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

// MARK: Bottom sheet for NavigationBar
class NavigationBarBottomSheetModel: ObservableObject {

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
            Action(iconName: "square.and.pencil", actionText: "Edit action"),
            Action(iconName: "square.and.arrow.up", actionText: "Share action"),
            Action(iconName: "plus", actionText: "Add action"),
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
    
    struct Action {
        let iconName: String
        let actionText: String
    }
}

struct NavigationBarVariantBottomSheet: View {

    // ======================
    // MARK: Store properties
    // ======================

    @EnvironmentObject var model: NavigationBarBottomSheetModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            ODSChipPicker(title: "Size",
                          selection: $model.titleSize,
                          chips: NavigationBarBottomSheetModel.TitleSize.chips)
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
