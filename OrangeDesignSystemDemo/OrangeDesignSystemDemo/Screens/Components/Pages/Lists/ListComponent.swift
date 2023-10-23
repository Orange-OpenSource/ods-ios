/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import SwiftUI

struct ListComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "screens.guidelines.lists.title".🌐
        imageName = "Lists"
        description = "screens.guidelines.lists.description".🌐
        variants = AnyView(ListVariants())
    }
}

struct ListVariants: View {
    var body: some View {
        VariantEntryItem(title:  "screens.guidelines.lists.variant.standard_lists", technicalElement: "ODSListItem()"){
            ListItemStandardVariant(model: ListItemStandardVariantModel())
        }
        VariantEntryItem(title: "screens.guidelines.lists.variant.with_selections", technicalElement: "ODSListItem()"){
            ListItemSelectionVariant(model: ListItemSelectionVariantModel())
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
