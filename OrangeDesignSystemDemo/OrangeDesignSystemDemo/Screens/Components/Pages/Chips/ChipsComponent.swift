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

// =======================
// MARK: - Chips Component
// =======================

struct ChipsComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.chips.title"
        imageName = "Chips"
        description = °°"screens.components.chips.description"
        variants = AnyView(ChipsVariants())
    }
}

// ======================
// MARK: - Chips Variants
// ======================

struct ChipsVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.chips.variant.action", technicalElement: "ODSActionChip()") {
            ActionChipVariant(model: ActionChipVariantModel())
                .navigationTitle("screens.components.chips.variant.action")
        }

        VariantEntryItem(title: "screens.components.chips.variant.input", technicalElement: "ODSInputChip()") {
            InputChipVariant(model: InputChipVariantModel())
                .navigationTitle("screens.components.chips.variant.input")
        }

        VariantEntryItem(title: "screens.components.chips.variant.choice", technicalElement: "ODSChoiceChip()") {
            ChoiceChipVariant(model: ChoiceChipVariantModel())
                .navigationTitle("screens.components.chips.variant.choice")
        }

        VariantEntryItem(title: "screens.components.chips.variant.filter", technicalElement: "ODSFilterChip()") {
            FilterChipVariant(model: FilterChipVariantModel())
                .navigationTitle("screens.components.chips.variant.filter")
        }
    }
}

#if DEBUG
struct ChipsViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChipsVariants()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            ChipsVariants()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
