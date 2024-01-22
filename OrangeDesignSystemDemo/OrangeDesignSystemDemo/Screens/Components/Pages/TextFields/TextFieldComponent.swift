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

// MARK: Component
struct TextFieldComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"shared.text_field"
        imageName = "Text edit menu"
        description = °°"screens.components.textfields.description"
        variants = AnyView(TextFieldVariants())
    }
}

struct TextFieldVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.textfields.variants.secure", technicalElement: "SecureField()") {
            SecureTextFieldVariant().navigationTitle("screens.components.textfields.variants.secure")
        }

        VariantEntryItem(title: "shared.text_field", technicalElement: "TextField()") {
            TextFieldVariant().navigationTitle("shared.text_field")
        }

        VariantEntryItem(title: "screens.components.textfields.variants.editor", technicalElement: "TextEditor()") {
            TextEditorVariant().navigationTitle("screens.components.textfields.variants.editor")
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
