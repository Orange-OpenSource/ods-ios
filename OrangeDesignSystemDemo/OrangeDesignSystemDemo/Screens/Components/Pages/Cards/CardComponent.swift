/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// ======================
// MARK: - Card Component
// ======================

struct CardComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "screens.guidelines.cards.title".🌐
        imageName = "Cards_1"
        description = "screens.guidelines.cards.description".🌐
        variants = AnyView(CardVariants())
    }
}

// =====================
// MARK: - Card Variants
// =====================

struct CardVariants: View {
    
    var body: some View {
        VariantEntryItem(title: "screens.guidelines.cards.variant.vertical_image_first".🌐, technicalElement: "ODSCardVerticalImageFirst()") {
            CardVerticalImageFirstVariant(model: CardVerticalImageFirstVariantModel())
                .navigationTitle("screens.guidelines.cards.variant.vertical_image_first")
        }
        
        VariantEntryItem(title: "screens.guidelines.cards.variant.vertical_header_first".🌐, technicalElement: "ODSCardVerticalHeaderFirst()") {
            CardVerticalHeaderFirstVariant(model: CardVerticalHeaderFirstVariantModel())
                .navigationTitle("screens.guidelines.cards.variant.vertical_header_first")
        }

        VariantEntryItem(title: "screens.guidelines.cards.variant.small".🌐, technicalElement: "ODSCardSmall") {
            CardSmallVariant(model: CardSmallVariantModel())
                .navigationTitle("screens.guidelines.cards.variant.small")
        }
        
        VariantEntryItem(title: "screens.guidelines.cards.variant.horizontal".🌐, technicalElement: "ODSCardHorizontal") {
            CardHorizontalVariant(model: CardHorizontalVariantModel())
                .navigationTitle("screens.guidelines.cards.variant.horizontal")
        }
    }
}

#if DEBUG
struct CardViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardVariants()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            CardVariants()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
