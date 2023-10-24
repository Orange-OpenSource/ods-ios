/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// =============================
// MARK: - Tab Bar Variant Model
// =============================

class ToolBarVariantModel: ObservableObject {
        
    // ================
    // MARK: Properties
    // ================

    @Published var itemsCount: Int
    @Published var itemType: ItemType {
        didSet {
            switch itemType {
            case .label:
                self.itemsCount = min(itemsCount, numberOfLabelItems)
            case .icon:
                break
            }
        }
    }
    
    @Published var showAlert: Bool
    var alertText: String
    
    enum ItemType: Int, CaseIterable {
        case label
        case icon
        
        var description: String {
            switch self {
            case .label:
                return "screens.guidelines.bars.tools.item_label".🌐
            case .icon:
                return "screens.guidelines.bars.tools.item_icon".🌐
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

        itemsCount = 2
        
        labelDescriptions = ["screens.guidelines.bars.tools.action_hint_1".🌐,
                             "screens.guidelines.bars.tools.action_hint_2".🌐,
                             "screens.guidelines.bars.tools.action_hint_3".🌐].map { str in
            ODSToolbarLabelDesription(text: str) {
                self.showAlert(with: str)
            }
        }

        iconDescriptions = ["plus", "square.and.arrow.up", "square.and.pencil", "folder", "trash"]
            .enumerated().map { (index, str) in
                ODSToolbarIconDesription(systemName: str) {
                    self.showAlert(with: "Item \(index+1)")
                }
        }
    }

    // =====================
    // MARK: Computed values
    // =====================

    var labelItems: ODSToolbarLabeledItems {
        let description1 = labelDescriptions[0]
        let description2 = labelDescriptions[1]
        let description3 = itemsCount == 3 ? labelDescriptions[2] : nil

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
        let description3 = itemsCount >= 3 ? iconDescriptions[2] : nil
        let description4 = itemsCount >= 4 ? iconDescriptions[3] : nil
        let description5 = itemsCount >= 5 ? iconDescriptions[4] : nil
        
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
        alertText = "screens.guidelines.bars.tools.alert_hint".localized(with: [text])
        showAlert = true
    }
}

// ===============================
// MARK: - Tab Bar Variant Options
// ===============================

struct ToolBarVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: ToolBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            ODSChipPicker(title: "screens.guidelines.bars.tools.picker_hint".🌐,
                              selection: $model.itemType,
                              chips: ToolBarVariantModel.ItemType.chips)
                
            switch model.itemType {
            case .label:
                Stepper("screens.guidelines.bars.tools.stepper_hint".localized(with: ["\(model.itemsCount)"]),
                        value: $model.itemsCount,
                        in: 2 ... model.numberOfLabelItems)
                .padding(.horizontal, ODSSpacing.m)
            case .icon:
                Stepper("screens.guidelines.bars.tools.stepper_hint".localized(with: ["\(model.itemsCount)"]),
                        value: $model.itemsCount,
                        in: 2 ... model.numberOfIconItems)
                .padding(.horizontal, ODSSpacing.m)
            }
        }
        .odsFont(.bodyBold)
    }
}
