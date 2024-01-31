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
            
            ODSChoiceChipPicker(
                title: Text("screens.components.lists.subtitle_option.title"),
                chips: SubtitleOption.chips,
                selection: $model.subtitleOption)
                .padding(.vertical, ODSSpacing.s)

            ODSChoiceChipPicker(
                title: Text("shared.leading"),
                chips: LeadingOption.chips,
                selection: $model.leadingOption)
                .padding(.vertical, ODSSpacing.s)

            ODSFilterChipPicker(
                title: Text("shared.trailing"),
                chips: StandardTrailingOption.chips,
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
