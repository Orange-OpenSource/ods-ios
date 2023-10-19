/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct NavigationBarComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "screens.guidelines.bars.navigation.title".🌐
        imageName = "Navigation bars"
        description = "screens.guidelines.bars.navigation.description".🌐
        
        variants = AnyView(NavigationBarVariants())
    }
}

struct NavigationBarVariants: View {

    var body: some View {
        VariantEntryItem(text: "screens.guidelines.bars.navigation.title".🌐,
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
