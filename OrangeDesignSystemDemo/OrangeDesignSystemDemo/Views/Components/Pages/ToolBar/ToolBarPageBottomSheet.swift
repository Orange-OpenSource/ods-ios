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

struct ToolBarVariantBottomSheet: View {

    // ======================
    // MARK: Store properties
    // ======================

    @EnvironmentObject var model: ToolBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Group {
                ODSChipPicker(title: "Items type",
                              selection: $model.itemType,
                              chips: ToolBarVariantModel.ItemType.chips)
                
                switch model.itemType {
                case .label:
                    Stepper("Number of items: \(model.labelItemsCount)",
                            value: $model.labelItemsCount,
                            in: 2 ... model.numberOfLabelItems)
                    .padding(.horizontal, ODSSpacing.m)
                case .icon:
                    Stepper("Number of items: \(model.iconItemsCount)",
                            value: $model.iconItemsCount,
                            in: 2 ... model.numberOfIconItems)
                    .padding(.horizontal, ODSSpacing.m)
                }
            }
            .odsFont(.bodyBold)            
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}

class ToolBarVariantModel: ObservableObject {
        
    // ======================
    // MARK: Store properties
    // ======================

    @Published var labelItemsCount: Int
    @Published var iconItemsCount: Int
    @Published var itemType: ItemType
    
    enum ItemType: Int, CaseIterable {
        case label
        case icon
        
        var description: String {
            switch self {
            case .label:
                return "Label"
            case .icon:
                return "Icon"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }

    var labelItems: [String]
    var iconItems: [String]

    // =================
    // MARK: Initializer
    // =================

    init() {
        labelItemsCount = 2
        labelItems = ["Action 1", "Action 2", "Action 3"]
        
        iconItemsCount = 2
        iconItems = ["plus", "square.and.arrow.up", "square.and.pencil", "folder", "trash"]
        
        itemType = .label
    }
    
    // =============
    // MARK: Helpers
    // =============
    var availableLableItems: (item1: String,
                              item2: String,
                              item3: String?) {
        let item1 = labelItems[0]
        let item2 = labelItems[1]
        let item3 = labelItemsCount == 3 ? labelItems[2] : nil
        
        return (item1: item1, item2: item2, item3: item3)
    }
    
    var numberOfLabelItems: Int {
        labelItems.count
    }
    
    var availableIconItems: (item1: String, item2: String,
                             item3: String?, item4: String?, item5: String?) {
        let item1 = iconItems[0]
        let item2 = iconItems[1]
        let item3 = iconItemsCount >= 3 ? iconItems[2] : nil
        let item4 = iconItemsCount >= 4 ? iconItems[3] : nil
        let item5 = iconItemsCount >= 5 ? iconItems[4] : nil
        
        return (item1: item1, item2: item2,
                item3: item3, item4: item4, item5: item5)
    }
    
    var numberOfIconItems: Int {
        iconItems.count
    }
}
