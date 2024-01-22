//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import OrangeDesignSystem
import SwiftUI

struct ListItemSelectionVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ListItemSelectionVariantModel

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
                chips: LeadingOption.chips,
                selection: $model.leadingOption)
                .padding(.vertical, ODSSpacing.s)

            ODSChoiceChipPicker(
                title: Text("shared.trailing"),
                chips: SelectionTrailingOption.chips,
                selection: $model.trailingOption)
                .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}
