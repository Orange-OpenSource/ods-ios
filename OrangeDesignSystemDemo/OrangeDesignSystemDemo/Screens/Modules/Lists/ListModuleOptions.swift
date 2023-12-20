//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ListModuleOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ListModuleOptionsModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            Toggle(isOn: $model.showHeader) {
                Text("screens.modules.lists.options.section.header")
                    .odsFont(.bodyLBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)

            Toggle(isOn: $model.showFooter) {
                Text("screens.modules.lists.options.section.footer")
                    .odsFont(.bodyLBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)

            ODSChipPicker(
                title: "screens.modules.lists.options.style".🌐,
                selection: $model.listStyleOption,
                chips: ListStyleOption.chips)
                .padding(.vertical, ODSSpacing.s)

            Toggle(isOn: $model.isEditable) {
                Text("screens.modules.lists.options.editable")
                    .odsFont(.bodyLBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}
