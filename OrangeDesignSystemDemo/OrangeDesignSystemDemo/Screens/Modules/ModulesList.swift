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

struct ModulesList: View {

    @AccessibilityFocusState private var requestFocus: Bool
    @EnvironmentObject private var themeProvider: ThemeProvider
    
    // =======================
    // MARK: Stored Properties
    // =======================

    private let columns = [GridItem(.flexible(), alignment: .topLeading)]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {

                    NavigationLink {
                        EmptyStateModule()
                            .odsNavigationTitle("screens.modules.empty_state.title.setup".🌐)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text("screens.modules.empty_state.title"),
                            imageSource: .image(imageFrom(resourceName: "EmptyState")))
                    }
                    
                    NavigationLink {
                        ListModule()
                            .odsNavigationTitle("screens.modules.lists.title".🌐)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text("screens.modules.lists.title"),
                            imageSource: .image(imageFrom(resourceName: "Lists")))
                            .accessibilityFocused($requestFocus)
                            //.odsRequestAccessibleFocus(_requestFocus) // <--- Don't know why it does not work each time
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    requestFocus = true
                                }
                            }
                    }

                    NavigationLink {
                        AboutModule()
                            .odsNavigationTitle("screens.modules.about.titles.setup".🌐)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text("shared.about"),
                            imageSource: .image(imageFrom(resourceName: "AboutImage")))
                    }

                    NavigationLink {
                        CardViewDemo()
                            .odsNavigationTitle("screens.modules.about.titles.card_collections".🌐)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text("screens.modules.about.titles.card_collections"),
                            imageSource: .image(imageFrom(resourceName: "Cards")))
                    }
                }
                .padding(.all, ODSSpacing.m)
            }
            .odsNavigationTitle("shared.modules".🌐)
            .navigationbarMenuForThemeSelection()
        }
        .navigationViewStyle(.stack)
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
