/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct CardViewDemo: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject private var themeProvider: ThemeProvider
    let columns = [GridItem(.flexible(), alignment: .topLeading)]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                NavigationLink {
                    ListOfVerticalImageFirstCard()
                        .navigationTitle("screens.modules.card_collections.titles.list")
                        .navigationbarMenuForThemeSelection()
                } label: {
                    ODSCardVerticalImageFirst(
                        title: Text("screens.modules.card_collections.titles.list"),
                        imageSource: .image(imageFrom(resourceName: "Cards")))
                }
                
                NavigationLink {
                    GrifOfSmallCards()
                        .navigationTitle("screens.modules.card_collections.titles.grid")
                        .navigationbarMenuForThemeSelection()
                } label: {
                    ODSCardVerticalImageFirst(
                        title: Text("screens.modules.card_collections.titles.grid"),
                        imageSource: .image(imageFrom(resourceName: "Cards_1")))
                }
            }
            .padding(.all, ODSSpacing.m)
        }
    }

    // ====================
    // MARK: Private helper
    // ====================

    private func imageFrom(resourceName: String) -> Image {
        themeProvider.imageFromResources(resourceName)
    }
}

#if DEBUG
struct CardViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        CardViewDemo()
            .previewInterfaceOrientation(.portrait)

        CardViewDemo()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
#endif
