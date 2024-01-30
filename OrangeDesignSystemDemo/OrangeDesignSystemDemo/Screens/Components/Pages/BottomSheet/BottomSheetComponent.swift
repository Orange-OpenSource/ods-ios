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

import BottomSheet
import OrangeDesignSystem
import SwiftUI

struct BottomSheetComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.bottom_sheets.title"
        imageName = "BottomSheet"
        description = °°"screens.components.bottom_sheets.description"
        variants = AnyView(BottomSheetVariants())
    }
}

struct BottomSheetVariants: View {
    var body: some View {

        VariantEntryItem(title: "screens.components.bottom_sheets.expanding", technicalElement: ".odsBottomSheetExpanding()") {
            ExpandingBottomSheetVariantHome(model: BottomSheetVariantModel())
                .odsNavigationTitle("screens.components.bottom_sheets.expanding".🌐)
        }

        VariantEntryItem(title: "screens.components.bottom_sheets.standard", technicalElement: ".odsBottomSheetStandard()") {
            StandardBottomSheetVariant()
                .odsNavigationTitle("screens.components.bottom_sheets.standard".🌐)
        }
    }
}
