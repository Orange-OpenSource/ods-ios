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

// ============================
// MARK: - Recirculation Module
// ============================

struct RecirculationModule: View {
    
    var body: some View {
        RecirculationModuleSetup(model: RecirculationModuleModel())
    }
}

// ===========================
// MARK: - Recirculation Setup
// ===========================

struct RecirculationModuleSetup: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State private var showDemo: Bool = false
    @ObservedObject var model: RecirculationModuleModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            ThemeProvider().imageFromResources("il_recirculation")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                Text("screens.modules.recirculation.description")

                Text("shared.modules.customize")
                    .odsFont(.headlineS)

                Toggle(isOn: $model.useLocalMock) {
                    Text("screens.modules.recirculation.option.use_embeded_mock")
                }
                .odsFont(.headlineS)
                .disabled(!model.hasRemoteDateSource) // If no backend URL, force to use mocks

                Toggle(isOn: $model.flattenAppsCategories) {
                    Text("screens.modules.recirculation.option.flatten_apps_sections")
                }.odsFont(.headlineS)

                Toggle(isOn: $model.cacheAppsIcons) {
                    Text("screens.modules.recirculation.option.cache_more_apps_icons")
                }.odsFont(.headlineS)

                Toggle(isOn: $model.enableHaptics) {
                    Text("screens.modules.recirculation.option.enable_haptics")
                }.odsFont(.headlineS)
                
                NavigationLink(isActive: $showDemo) {
                    RecirculationModuleDemo(model: model)
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

