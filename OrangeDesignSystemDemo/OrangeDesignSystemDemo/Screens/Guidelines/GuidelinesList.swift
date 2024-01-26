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

struct GuidelinesList: View {

    @EnvironmentObject private var themeProvider: ThemeProvider
    
    // =======================
    // MARK: Stored properties
    // =======================

    private let guidelines: [Guideline]
    private let columns = [GridItem(.flexible(), alignment: .topLeading)]

    init() {
        guidelines = [
            ColorsGuideline(),
            TypographyGuideline(),
            SpacingsGuideline(),
        ]
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                    ForEach(guidelines, id: \.id) { guideline in
                        NavigationLink {
                            GuidelinePage(guideline: guideline)
                        } label: {
                            ODSCardVerticalImageFirst(
                                title: Text(guideline.name),
                                imageSource: .image(imageFrom(resourceName: guideline.imageName)))
                        }
                    }
                }
                .padding(.all, ODSSpacing.m)
                .navigationbarMenuForThemeSelection()
                .modifier(AccssibleNavigationTitleModifier(title: "shared.guidelines"))
                
            }

            GuidelinePage(guideline: guidelines[0]) // Why ?
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
struct GuidelinesListView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            GuidelinesList()
        }
    }
}
#endif
