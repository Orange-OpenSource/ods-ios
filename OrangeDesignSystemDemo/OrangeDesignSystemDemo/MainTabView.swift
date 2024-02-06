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
