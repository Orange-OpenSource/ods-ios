/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct StandardListVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: StandardListVariantModel

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
                          selection: $model.trailingOptions,
                          allowZeroSelection: true,
                          chips: TrailingOption.chips)
                .padding(.vertical, ODSSpacing.s)
            
            Toggle(isOn: $model.showDetails) {
                Text("screens.guidelines.lists.picker.navigate").odsFont(.bodyBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}
