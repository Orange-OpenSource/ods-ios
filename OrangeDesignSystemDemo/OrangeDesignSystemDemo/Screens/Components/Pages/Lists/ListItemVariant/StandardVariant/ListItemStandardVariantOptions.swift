//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ListItemStandardVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ListItemStandardVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            Toggle(isOn: $model.showSubtitle) {
                Text("shared.subtitle").odsFont(.bodyBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)

            ODSChipPicker(title: °°"shared.leading",
                          selection: $model.leadingOption,
                          chips: LeadingOption.chips)
                .padding(.vertical, ODSSpacing.s)

            ODSChipPicker(title: °°"shared.trailing",
                          selection: $model.trailingOptions,
                          allowZeroSelection: true,
                          chips: StandardTrailingOption.chips)
                .padding(.vertical, ODSSpacing.s)

            Toggle(isOn: $model.navigate) {
                Text("screens.components.lists.picker.navigate").odsFont(.bodyBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}
