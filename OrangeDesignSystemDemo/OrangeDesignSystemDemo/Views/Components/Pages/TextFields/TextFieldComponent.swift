//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import OrangeDesignSystem
import SwiftUI

// MARK: Component
struct TextFieldComponent: Component {
    
    // ======================
    // MARK: Store properties
    // ======================

    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    // =================
    // MARK: Initilizers
    // =================

    init() {
        title = "Text field"
        image = Image("Text edit menu")
        description = "The text field component comprises the text field itself, text selection and the edit menu. Some elements are styled and some are native."
        
        variants = AnyView(TextFieldVariants())
    }
}

struct TextFieldVariants: View {

    var body: some View {
        VariantEntryItem(text: "Secure text field", technicalElement: "SecureField()") {
            SecureTextFieldVariant().navigationTitle("Secure text field")
        }

        VariantEntryItem(text: "Text field", technicalElement: "TextField()") {
            TextFieldVariant().navigationTitle("Text field")
        }

        VariantEntryItem(text: "Text editor", technicalElement: "TextEditor()") {
            TextEditorVariant().navigationTitle("Text editor")
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

