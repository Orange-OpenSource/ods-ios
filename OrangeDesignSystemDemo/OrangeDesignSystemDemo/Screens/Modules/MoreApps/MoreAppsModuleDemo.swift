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

struct MoreAppsModuleDemo: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: MoreAppsModuleModel
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ODSMoreAppsView(
                dataSource: model.dataSource,
                flattenApps: model.flattenAppsCategories,
                cacheAppsIcons: model.cacheAppsIcons,
                enableHaptics: model.enableHaptics)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("screens.modules.moreApps.title")
    }
}


#if DEBUG
struct AppsMoreAppsModuleDemo_Previews: PreviewProvider {

    static var previews: some View {
        MoreAppsModuleSetup(model: MoreAppsModuleModel())
    }
}
#endif
