/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct ModulesList: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject private var themeProvider: ThemeProvider
    private let columns = [GridItem(.flexible(), alignment: .topLeading)]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                    NavigationLink {
                        AboutModule()
                            .navigationTitle("screens.modules.about.titles.setup")
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text("shared.about"),
                            imageSource: .image(imageFrom(resourceName: "AboutImage")))
                    }
                    
                    NavigationLink {
                        CardViewDemo()
                            .navigationTitle("screens.modules.about.titles.card_collections")
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text("screens.modules.about.titles.card_collections"),
                            imageSource: .image(imageFrom(resourceName: "Cards")))
                    }
                }
                .padding(.all, ODSSpacing.m)
            }
            .navigationTitle("shared.modules")
            .navigationbarMenuForThemeSelection()
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
struct ModulesList_Previews: PreviewProvider {
    static var previews: some View {
        ModulesList()
    }
}
#endif
