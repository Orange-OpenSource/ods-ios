//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {
            GuidelinesList()
                .tabItem {
                    Label(°°"shared.guidelines", image: "Guideline-DNA_32")
                }
            ComponentsList()
                .tabItem {
                    Label(°°"main_view.tabs.components", image: "component-atom_32")
                }
            ModulesList()
                .tabItem {
                    Label(°°"shared.modules", image: "Module-molecule_32")
                }
            AboutScreen()
                .tabItem {
                    Label(°°"shared.about", image: "info_32")
                }
        }
    }
}

#if DEBUG
struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            MainTabView().preferredColorScheme($0)
        }
    }
}
#endif
