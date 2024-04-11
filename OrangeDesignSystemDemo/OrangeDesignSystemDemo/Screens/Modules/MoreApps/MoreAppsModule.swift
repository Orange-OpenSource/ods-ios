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

// =======================
// MARK: - MoreApps Module
// =======================

struct MoreAppsModule: View {
    
    var body: some View {
        MoreAppsModuleSetup(model: MoreAppsModuleModel())
    }
}

// ======================
// MARK: - MoreApps Setup
// ======================

struct MoreAppsModuleSetup: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State private var showDemo: Bool = false
    @ObservedObject var model: MoreAppsModuleModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            ThemeProvider().imageFromResources(name: "il_moreApps")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                Text("screens.modules.moreApps.description")

                Text("shared.modules.customize")
                    .odsFont(.headlineS)

                Toggle(isOn: $model.useLocalDataSource) {
                    Text("screens.modules.moreApps.option.use_embeded_data_source")
                }
                .odsFont(.headlineS)
                .disabled(!model.hasRemoteDateSource) // If no backend URL, force to use mocks

                Toggle(isOn: $model.flattenAppsCategories) {
                    Text("screens.modules.moreApps.option.flatten_apps_sections")
                }.odsFont(.headlineS)

                Toggle(isOn: $model.cacheAppsIcons) {
                    Text("screens.modules.moreApps.option.cache_more_apps_icons")
                }.odsFont(.headlineS)

                Toggle(isOn: $model.enableHaptics) {
                    Text("screens.modules.moreApps.option.enable_haptics")
                }.odsFont(.headlineS)
                
                NavigationLink(isActive: $showDemo) {
                    MoreAppsModuleDemo(model: model)
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

