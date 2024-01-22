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

struct ListComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.lists.title"
        imageName = "Lists"
        description = °°"screens.components.lists.description"
        variants = AnyView(ListVariants())
    }
}

struct ListVariants: View {
    var body: some View {
        VariantEntryItem(title: "screens.components.lists.variant.standard_lists", technicalElement: "ODSListItem()") {
            ListItemStandardVariant(model: ListItemStandardVariantModel())
                .navigationTitle("screens.components.lists.variant.standard_lists")
        }
        VariantEntryItem(title: "screens.components.lists.variant.with_selections", technicalElement: "ODSListItem()") {
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
