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

struct NavigationBarComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.bars.navigation.title"
        imageName = "Navigation bars"
        description = °°"screens.components.bars.navigation.description"
        variants = AnyView(NavigationBarVariants())
    }
}

struct NavigationBarVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.bars.navigation.title",
                         technicalElement: "NavigationView",
                         showThemeSelectionInNavigationBar: false) {
            NavigationBarVariant(model: NavigationBarVariantModel())
        }
    }
}

struct NavigationBarVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: NavigationBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            NavigationBarVariantContent(model: model)
        } options: {
            NavigationBarVariantOptions(model: model)
        }
    }
}

#if DEBUG
struct NavigationBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    NavigationBarVariants()
                }
            }
        }
    }
}
#endif
