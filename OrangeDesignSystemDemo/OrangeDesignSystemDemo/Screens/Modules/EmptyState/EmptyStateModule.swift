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
        EmptyStateModuleSetup(model: EmptyStateModuleModel())
    }
}

// ===================
// MARK: - About Setup
// ===================

struct EmptyStateModuleSetup: View {

    @EnvironmentObject private var themeProvider: ThemeProvider

    // =======================
    // MARK: Stored Properties
    // =======================

    @State private var showDemo: Bool = false
    @ObservedObject var model: EmptyStateModuleModel


    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            themeProvider.imageFromResources(name: "il_emptyState")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                Text("screens.modules.empty_state.description")

                Text("shared.modules.customize")
                    .odsFont(.headlineS)

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
                    ODSButton(text: Text("shared.modules.button.view_demo"), emphasis: .high, fullWidth: true) {
                        showDemo.toggle()
                    }
                }
            }
            .padding(.all, ODSSpacing.m)
        }
    }
}

