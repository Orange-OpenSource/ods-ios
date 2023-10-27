/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import SwiftUI
import OrangeDesignSystem

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
                        Text("screens.modules.card_collections.texts.bon_app")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text(recipe.title),
                            imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                            subtitle: Text(recipe.subtitle),
                            text: Text(recipe.description)
                        )
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

