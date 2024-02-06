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

struct TabBarComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.bars.tabs.title"
        imageName = "Tab bar"
        description = °°"screens.components.bars.tabs.description"
        variants = AnyView(TabBarVariants())
    }
}

private struct TabBarVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.bars.tabs.title", technicalElement: "TabView") {
            TabBarVariant(model: TabBarVariantModel())
                .odsNavigationTitle("screens.components.bars.tabs.title".🌐)
        }
    }
}

#if DEBUG
struct TabBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    TabBarVariants()
                }
            }
        }
    }
}
#endif
