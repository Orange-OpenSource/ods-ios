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
                Text("shared.subtitle").odsFont(.bodyLBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)

            ODSChoiceChipPicker(
                title: Text("shared.leading"),
                elements: LeadingOption.elements,
                selection: $model.leadingOption)
                .padding(.vertical, ODSSpacing.s)

            ODSFilterChipPcicker(
                title: Text("shared.trailing"),
                elements: StandardTrailingOption.elements,
                selection: $model.trailingOptions,
                placement: .carousel)
                .padding(.vertical, ODSSpacing.s)

            Toggle(isOn: $model.navigate) {
                Text("screens.components.lists.picker.navigate").odsFont(.bodyLBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}
