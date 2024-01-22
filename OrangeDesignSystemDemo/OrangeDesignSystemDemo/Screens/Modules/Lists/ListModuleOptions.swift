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

            ODSChoiceChipPicker(
                title: Text("screens.modules.lists.options.style"),
                chips: ListStyleOption.elemnts,
                selection: $model.listStyleOption)
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
