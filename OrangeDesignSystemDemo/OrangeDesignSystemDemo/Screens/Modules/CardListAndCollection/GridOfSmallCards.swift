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
            if sizeCategory.isAccessibilityCategory {
                recipesCards()
                .padding(.all, ODSSpacing.m)
            } else {
                LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                    recipesCards()
                }
                .padding(.all, ODSSpacing.m)
            }
        }
    }
    
    private func recipesCards() -> some View {
        ForEach(RecipeBook.shared.recipes, id: \.id) { recipe in
            NavigationLink {
                Text("shared.bon_app")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationbarMenuForThemeSelection()
            } label: {
                ODSCardSmall(
                    title: Text(recipe.title),
                    imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                    subtitle: Text(recipe.subtitle))
            }
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
