/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// MARK: Component
struct TextFieldComponent: Component {
    
    // ======================
    // MARK: Store properties
    // ======================

    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    // =================
    // MARK: Initilizers
    // =================

    init() {
        title = "shared.text_field".🌐
        imageName = "Text edit menu"
        description = "screens.guidelines.textfields.description".🌐
        variants = AnyView(TextFieldVariants())
    }
}

struct TextFieldVariants: View {

    var body: some View {
        VariantEntryItem(text: "screens.guidelines.textfields.variants.secure", technicalElement: "SecureField()") {
            SecureTextFieldVariant().navigationTitle("screens.guidelines.textfields.variants.secure")
        }

        VariantEntryItem(text: "shared.text_field", technicalElement: "TextField()") {
            TextFieldVariant().navigationTitle("screens.guidelines.textfields.variants.simple")
        }

        VariantEntryItem(text: "screens.guidelines.textfields.variants.editor", technicalElement: "TextEditor()") {
            TextEditorVariant().navigationTitle("shared.text_field")
        }
    }
}

#if DEBUG
struct TextFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    TextFieldVariants()
                }
            }
        }
    }
}
#endif

