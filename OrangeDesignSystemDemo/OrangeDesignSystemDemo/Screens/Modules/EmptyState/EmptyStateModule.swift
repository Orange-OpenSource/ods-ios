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

import SwiftUI
import OrangeDesignSystem

// =========================
// MARK: - EmptyState Module
// =========================

struct EmptyStateModule: View {
    
    var body: some View {
        EmptyStateModuleSatup(model: EmptyStateModuleModel())
    }
}

// ===================
// MARK: - About Setup
// ===================

struct EmptyStateModuleSatup: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State var showDemo: Bool = false
    @ObservedObject var model: EmptyStateModuleModel

    // =================
    // MARK: Initializer
    // =================

    init(model: EmptyStateModuleModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            Image("il_emptyState")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                Text("screens.modules.empty_state.description")

                Text("screens.modules.empty_state.customize")
                    .odsFont(.headlineS)

//                Text("screens.modules.about.mandatory")

                ODSChoiceChipPicker(
                    title: Text("misc.usage"),
                    chips: EmptyStateModuleModel.UsageOption.chips,
                    selection: $model.usageOption)
                    .padding(.horizontal, -ODSSpacing.m)

                Toggle("shared.button", isOn: $model.showButton).odsFont(.headlineS)
                Toggle("shared.subtitle", isOn: $model.showSubtitle).odsFont(.headlineS)
                
                NavigationLink(isActive: $showDemo) {
                    EmptyStateModuleDemo(model: model)
                } label: {
                    ODSButton(text: Text("screens.modules.empty_state.button.view_demo"), emphasis: .high, fullWidth: true) {
                        showDemo.toggle()
                    }
                }

            }
            .padding(.all, ODSSpacing.m)
        }
    }
}

