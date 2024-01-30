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

// ======================
// MARK: - Card Component
// ======================

struct CardComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.cards.title"
        imageName = "Cards_1"
        description = °°"screens.components.cards.description"
        variants = AnyView(CardVariants())
    }
}

// =====================
// MARK: - Card Variants
// =====================

struct CardVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.cards.variant.vertical_image_first", technicalElement: "ODSCardVerticalImageFirst()") {
            CardVerticalImageFirstVariant(model: CardVerticalImageFirstVariantModel())
                .odsNavigationTitle("screens.components.cards.variant.vertical_image_first".🌐)
        }

        VariantEntryItem(title: "screens.components.cards.variant.vertical_header_first", technicalElement: "ODSCardVerticalHeaderFirst()") {
            CardVerticalHeaderFirstVariant(model: CardVerticalHeaderFirstVariantModel())
                .odsNavigationTitle("screens.components.cards.variant.vertical_header_first".🌐)
        }

        VariantEntryItem(title: "screens.components.cards.variant.small", technicalElement: "ODSCardSmall") {
            CardSmallVariant(model: CardSmallVariantModel())
                .odsNavigationTitle("screens.components.cards.variant.small".🌐)
        }

        VariantEntryItem(title: "screens.components.cards.variant.horizontal", technicalElement: "ODSCardHorizontal") {
            CardHorizontalVariant(model: CardHorizontalVariantModel())
                .odsNavigationTitle("screens.components.cards.variant.horizontal".🌐)
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
