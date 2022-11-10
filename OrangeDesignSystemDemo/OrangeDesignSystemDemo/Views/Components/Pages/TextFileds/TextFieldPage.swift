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
        VariantEntyItem(text: "Secure text field", technicalElement: "SecureField()") {
            VariantSecureTextField().navigationTitle("Secure text field")
        }

        VariantEntyItem(text: "Text field", technicalElement: "TextField()") {
            VariantTextField().navigationTitle("Text field")
        }

        VariantEntyItem(text: "Text editor", technicalElement: "TextEditor()") {
            VariantTextEditor().navigationTitle("Text editor")
        }
    }
}

// MARK: Variants
struct VariantSecureTextField: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    @State private var textToEdit: String = ""
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        VStack {
            SecureField("secure text to edit", text: $textToEdit)
                .odsTextFieldStyle()
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
            
            Spacer()
        }
    }
}

struct VariantTextEditor: View {

    var body: some View {
        VariantCapitalizedText(model: VariantTextFieldModel(textInputType: .textEditor))
    }
}

struct VariantTextField: View {
    var body: some View {
        VariantCapitalizedText(model: VariantTextFieldModel(textInputType: .textField))
    }
}


private struct VariantCapitalizedText: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: VariantTextFieldModel
    
    @ViewBuilder var textField: some View {
        switch model.textInputType {
        case .textField:
            TextField(model.defaultText, text: $model.textToEdit)
        case .textEditor:
            TextEditor(text: $model.textToEdit)
        }
    }
    
    @FocusState private var isFocused: Bool

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            VStack {
                textField
                    .textInputAutocapitalization(model.selectedCapitalizationType.textInputAutocapitalization)
                    .odsTextFieldStyle()
                    .id(model.selectedCapitalizationType.description)
                    .padding(.horizontal, ODSSpacing.s)
                    .padding(.top, ODSSpacing.m)
                    .focused($isFocused)
                    .onAppear {
                        isFocused = true
                    }
                
                Spacer()
            }
            
            BottomSheet(showContent: false) {
                VariantTextFieldBottomSheet()
            }
            .environmentObject(model)
        }
    }
    
    // ==================
    // MARK: Initializers
    // ==================

    init(model: VariantTextFieldModel) {
        self.model = model
        
        if case .textEditor = model.textInputType {
            UITextView.appearance().backgroundColor = .clear
        }
    }
}


// MARK: Bottom Sheet
private struct VariantTextFieldBottomSheet: View {

    // ======================
    // MARK: Store properties
    // ======================

    @EnvironmentObject var model: VariantTextFieldModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            ODSChipPicker(title: "Capitalization",
                          selection: $model.selectedCapitalizationType,
                          chips: model.capitalizationTypeChips)
                .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}

#if DEBUG
import OrangeTheme

struct TextFieldPage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { colorScheme in
            ODSThemeableView(theme: OrangeThemeFactory().theme) {
                NavigationView {
                    List {
                        TextFieldVariants()
                    }
                }
            }
            .preferredColorScheme(colorScheme)
        }
    }
}
#endif

