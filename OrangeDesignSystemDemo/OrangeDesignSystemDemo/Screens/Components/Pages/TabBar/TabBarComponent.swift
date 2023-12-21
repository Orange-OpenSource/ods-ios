//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
                .navigationTitle("screens.components.bars.tabs.title")
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
