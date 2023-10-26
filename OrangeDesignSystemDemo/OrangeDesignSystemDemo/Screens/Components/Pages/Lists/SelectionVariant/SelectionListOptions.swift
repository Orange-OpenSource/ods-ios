/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct SelectionListVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: SelectionListVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            Toggle(isOn: $model.showSubtitle) {
                Text("screens.guidelines.lists.toggle.subtitle").odsFont(.bodyBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)

            ODSChipPicker(title: "screens.guidelines.lists.picker.leading".🌐,
                          selection: $model.leadingIconOption,
                          chips: LeadingIconOption.chips)
                .padding(.vertical, ODSSpacing.s)

            ODSChipPicker(title: "screens.guidelines.lists.picker.trailing".🌐,
                          selection: $model.trailingOption,
                          chips: ODSListSelectionItemModel.TrailingSelection.chips)
                .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}

extension ODSListSelectionItemModel.TrailingSelection {

    private var description: String {
        switch self {
        case .checkmark:
            return "screens.guidelines.lists.selection.description.checkmark".🌐
        case .toggle:
            return "screens.guidelines.lists.selection.description.switch".🌐
        }
    }
        
    private var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
        
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}
