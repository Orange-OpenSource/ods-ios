/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI
import BottomSheet

struct BottomSheetComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "screens.guidelines.bottom_sheets.title"
        imageName = "BottomSheet"
        description = "screens.guidelines.bottom_sheets.description"
        variants = AnyView(BottomSheetVariants())
    }
}

struct BottomSheetVariants: View {
    var body: some View {
        VariantEntryItem(text: "screens.guidelines.bottom_sheets.expanding".🌐, technicalElement: ".odsBottomSheetExpanding()") {
            ExpandingBottomSheetVariantHome(model: BottomSheetVariantModel())
                .navigationTitle("screens.guidelines.bottom_sheets.expanding")
        }
        
        VariantEntryItem(text: "screens.guidelines.bottom_sheets.standard".🌐, technicalElement: ".odsBottomSheetStandard()") {
            StandardBottomSheetVariant()
                .navigationTitle("screens.guidelines.bottom_sheets.standard")
        }
    }
}

