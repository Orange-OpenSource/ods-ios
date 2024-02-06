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

struct ListOfVerticalImageFirstCard: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let columns = [GridItem(.flexible(), alignment: .topLeading)]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                ForEach(RecipeBook.shared.recipes, id: \.id) { recipe in
                    NavigationLink {
                        Text("shared.bon_app")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text(recipe.title),
                            imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                            subtitle: Text(recipe.subtitle),
                            text: Text(recipe.description))
                    }
                }
            }
            .padding(.all, ODSSpacing.m)
        }
    }
}

#if DEBUG
struct ListOfVerticalImageFirstCard_Previews: PreviewProvider {
    static var previews: some View {
        ListOfVerticalImageFirstCard()
            .previewInterfaceOrientation(.portrait)

        ListOfVerticalImageFirstCard()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3)

        ListOfVerticalImageFirstCard()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
#endif
