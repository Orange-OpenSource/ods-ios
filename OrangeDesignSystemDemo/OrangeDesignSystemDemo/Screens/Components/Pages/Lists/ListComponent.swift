//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ListComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        title = °°"screens.components.lists.title"
        imageName = "Lists"
        description = °°"screens.components.lists.description"
        variants = AnyView(ListVariants())
    }
}

struct ListVariants: View {
    var body: some View {
        VariantEntryItem(title: °°"screens.components.lists.variant.standard_lists", technicalElement: "ODSListItem()") {
            ListItemStandardVariant(model: ListItemStandardVariantModel())
                .navigationTitle("screens.components.lists.variant.standard_lists")
        }
        VariantEntryItem(title: °°"screens.components.lists.variant.with_selections", technicalElement: "ODSListItem()") {
            ListItemSelectionVariant(model: ListItemSelectionVariantModel())
                .navigationTitle("screens.components.lists.variant.with_selections")
        }
    }
}

#if DEBUG
struct ListComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    ListVariants()
                }
            }
        }
    }
}
#endif
