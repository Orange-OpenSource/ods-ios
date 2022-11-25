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

struct TabBarVariantBottomSheet: View {

    // ======================
    // MARK: Store properties
    // ======================

    @EnvironmentObject var model: TabBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Group {
                Stepper("Number of items: \(model.itemsCount)",
                        value: $model.itemsCount,
                        in: 1 ... model.numberOfItems)
            }
            .padding(.horizontal, ODSSpacing.m)
            .odsFont(.bodyBold)
            
            ODSChipPicker(title: "Badge options",
                          selection: $model.badgeOption,
                          chips: TabBarVariantModel.BadgeOption.chips)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}

class TabBarVariantModel: ObservableObject {
    
    // ======================
    // MARK: Store properties
    // ======================

    @Published var itemsCount: Int
    @Published var badgeOption: BadgeOption
    
    let itemDescriptions: [ItemDescription]

    // =================
    // MARK: Initializer
    // =================

    init() {
        itemsCount = 1
        badgeOption = .none
        
        itemDescriptions = [
            ItemDescription(iconName: "star.fill", text: "Item 1", contentText: "Content view 1"),
            ItemDescription(iconName: "star.fill", text: "Item 2", contentText: "Content view 2"),
            ItemDescription(iconName: "star.fill", text: "Item 3", contentText: "Content view 3"),
            ItemDescription(iconName: "star.fill", text: "Item 4", contentText: "Content view 4"),
            ItemDescription(iconName: "star.fill", text: "Item 5", contentText: "Content view 5"),
        ]
    }
    
    // =============
    // MARK: Helpers
    // =============
    
    var availableItems: [ItemDescription] {
        Array(itemDescriptions.prefix(itemsCount))
    }
    
    var numberOfItems: Int {
        itemDescriptions.count
    }
    
    struct ItemDescription {
        let iconName: String
        let text: String
        let contentText: String
    }
    
    enum BadgeOption: Int, CaseIterable {
        case none = 0
        case count
        case text
        
        var description: String {
            switch self {
            case .none:
                return "None"
            case .count:
                return "Count"
            case .text:
                return "Text"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }
}
