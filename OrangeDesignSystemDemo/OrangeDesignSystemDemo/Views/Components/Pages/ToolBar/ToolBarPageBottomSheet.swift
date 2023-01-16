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
    
    @Published var showAlert: Bool
    var alertText: String
    
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

    private var labelDescriptions: [ODSToolbarLabelDesription] = []
    private var iconDescriptions: [ODSToolbarIconDesription] = []

    // =================
    // MARK: Initializer
    // =================

    init() {
        itemType = .label
        
        showAlert = false
        alertText = ""

        labelItemsCount = 2
        iconItemsCount = 2
        
        labelDescriptions = ["Action 1", "Action 2", "Action 3"].map { str in
            ODSToolbarLabelDesription(text: str) {
                self.showAlert(with: str)
            }
        }

        iconDescriptions = ["plus", "square.and.arrow.up", "square.and.pencil", "folder", "trash"]
            .enumerated().map { (index, str) in
                ODSToolbarIconDesription(systemName: str) {
                    self.showAlert(with: "icon \(index+1)")
                }
        }
    }

    // =====================
    // MARK: Computed values
    // =====================

    var labelItems: ODSToolbarLabeledItems {
        let description1 = labelDescriptions[0]
        let description2 = labelDescriptions[1]
        let description3 = labelItemsCount == 3 ? labelDescriptions[2] : nil

        return ODSToolbarLabeledItems(description1: description1,
                                      description2: description2,
                                      description3: description3)
    }
    
    var numberOfLabelItems: Int {
        labelDescriptions.count
    }
    
    var iconItems: ODSToolbarIconsItems {
        let description1 = iconDescriptions[0]
        let description2 = iconDescriptions[1]
        let description3 = iconItemsCount >= 3 ? iconDescriptions[2] : nil
        let description4 = iconItemsCount >= 4 ? iconDescriptions[3] : nil
        let description5 = iconItemsCount >= 5 ? iconDescriptions[4] : nil
        
        return ODSToolbarIconsItems(description1: description1,
                                    description2: description2,
                                    description3: description3,
                                    description4: description4,
                                    description5: description5)
    }
        
    var numberOfIconItems: Int {
        iconDescriptions.count
    }
    
    // =============
    // MARK: Helpers
    // =============

    private func showAlert(with text: String) {
        alertText = "\(text): clicked"
        showAlert = true
    }

}
