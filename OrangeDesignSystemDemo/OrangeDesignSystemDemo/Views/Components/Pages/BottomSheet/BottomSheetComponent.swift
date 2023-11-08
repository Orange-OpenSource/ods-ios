//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import BottomSheet
import OrangeDesignSystem
import SwiftUI

struct BottomSheetComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        title = "screens.components.bottom_sheets.title"
        imageName = "BottomSheet"
        description = "screens.components.bottom_sheets.description"
        variants = AnyView(BottomSheetVariants())
    }
}

struct BottomSheetVariants: View {
    var body: some View {
        VariantEntryItem(text: °°"screens.components.bottom_sheets.expanding", technicalElement: ".odsBottomSheetExpanding()") {
            ExpandingBottomSheetVariantHome(model: BottomSheetVariantModel())
                .navigationTitle("screens.components.bottom_sheets.expanding")
        }

        VariantEntryItem(text: °°"screens.components.bottom_sheets.standard", technicalElement: ".odsBottomSheetStandard()") {
            StandardBottomSheetVariant()
                .navigationTitle("screens.components.bottom_sheets.standard")
        }
    }
}
