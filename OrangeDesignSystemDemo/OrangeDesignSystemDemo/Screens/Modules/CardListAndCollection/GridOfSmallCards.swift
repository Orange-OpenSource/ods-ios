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

struct GrifOfSmallCards: View {

    @Environment(\.sizeCategory) private var sizeCategory
    @AccessibilityFocusState private var requestFocus: AccessibilityFocusable?
    
    // =======================
    // MARK: Stored Properties
    // =======================

    private let columns = [
        GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .topLeading),
    ]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            grid {
                ForEach(RecipeBook.shared.recipes, id: \.id) { recipe in
                    NavigationLink {
                        Text("shared.bon_app")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        card(for: recipe)
                            .accessibilityFocused($requestFocus, equals: .some(id: recipe.id))
                        // Placed here below to be sure 'components' will be evaluated in good time (compared to some assignement higher and later in body)
                            .odsRequestAccessibleFocus(_requestFocus, for: .some(id: RecipeBook.shared.recipes[0].id)) // TODO: Dirty, need to find nicer solution
                    }
                }
            }.padding(.all, ODSSpacing.s)
        }
        .odsNavigationTitle("main_view.tabs.components".🌐)
        .navigationbarMenuForThemeSelection()
    }
    

    // =====================
    // MARK: Private helper
    // =====================
    
    @ViewBuilder
    private func grid<Content>(content: () -> Content) -> some View where Content: View {
        if sizeCategory.isAccessibilityCategory {
            content()
        } else {
            LazyVGrid(columns: columns, spacing: ODSSpacing.none) {
                content()
            }
        }
    }
        
    @ViewBuilder
    private func card(for recipe: Recipe) -> some View {
        if sizeCategory.isAccessibilityCategory {
            ODSCardVerticalImageFirst(
                title: Text(recipe.title),
                imageSource: .asyncImage(recipe.url, Image("placeholder", bundle: Bundle.ods)),
                subtitle: Text(recipe.subtitle))
        } else {
            ODSCardSmall(
                title: Text(recipe.title),
                imageSource: .asyncImage(recipe.url, Image("placeholder", bundle: Bundle.ods)),
                subtitle: Text(recipe.subtitle))
        }
    }
}

#if DEBUG
struct GrifOfSmallCard_Previews: PreviewProvider {
    static var previews: some View {
        GrifOfSmallCards()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3)

        GrifOfSmallCards()
            .previewInterfaceOrientation(.landscapeRight)
            .environment(\.dynamicTypeSize, .accessibility3)
    }
}
#endif
