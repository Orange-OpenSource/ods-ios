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

import SwiftUI
import OrangeDesignSystem

// MARK: Variants

struct TextEditorVariant: View {

    var body: some View {
        CapitalizedTextInputsVariant(model: CapitalizedTextInputsVariantModel(inputType: .textEditor))
    }
}

struct TextFieldVariant: View {
    var body: some View {
        CapitalizedTextInputsVariant(model: CapitalizedTextInputsVariantModel(inputType: .textField))
    }
}

private struct CapitalizedTextInputsVariant: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: CapitalizedTextInputsVariantModel
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
            
            BottomSheet {
                CapitalizedTextInputsVariantOptions(model: model)
            }
        }
    }
    
    // ==================
    // MARK: Initializers
    // ==================

    init(model: CapitalizedTextInputsVariantModel) {
        self.model = model
        
        if case .textEditor = model.inputType {
            UITextView.appearance().backgroundColor = .clear
        }
    }

    // =============
    // MARK: Helpers
    // =============

    @ViewBuilder
    private var textField: some View {
        switch model.inputType {
        case .textField:
            TextField(model.defaultText, text: $model.textToEdit)
        case .textEditor:
            TextEditor(text: $model.textToEdit)
        }
    }
}

private class CapitalizedTextInputsVariantModel: ObservableObject {
    
    // ====================
    // MARK: Internal types
    // ====================

    enum CapitalizationType: Int, CaseIterable {
        case never = 0
        case characters
        case words
        case sentences
        
        var textInputAutocapitalization: TextInputAutocapitalization {
            switch self {
            case .never: return .never
            case .characters: return .characters
            case .words: return .words
            case .sentences: return .sentences
            }
        }
        
        var description: String {
            switch self {
            case .never: return "none"
            case .characters: return "characters"
            case .words: return "words"
            case .sentences: return "sentences"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }
    
    enum InputType {
        case textField
        case textEditor
    }
    
    // ======================
    // MARK: Store properties
    // ======================

    @Published var selectedCapitalizationType: CapitalizationType {
        didSet { reseetTextToEdit() }
    }
    
    @Published var textToEdit: String = ""
    
    var defaultText: String  {
        let text = "text to edit."
        switch selectedCapitalizationType {
        case .never:
            return text
        case .characters:
            return text.uppercased()
        case .words:
            return text.capitalized
        case .sentences:
            return "Text to edit."
        }
    }
    
    let inputType: InputType
    
    // ==================
    // MARK: Initializers
    // ==================

    init(inputType: InputType) {
        
        self.inputType = inputType
        selectedCapitalizationType = CapitalizationType.never
        
        reseetTextToEdit()
    }
    
    private func reseetTextToEdit() {
        switch inputType {
        case .textField:
            textToEdit = ""
        case .textEditor:
            textToEdit = defaultText
        }
    }
}

private struct CapitalizedTextInputsVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: CapitalizedTextInputsVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            ODSChipPicker(title: "Capitalization",
                          selection: $model.selectedCapitalizationType,
                          chips: CapitalizedTextInputsVariantModel.CapitalizationType.chips)
                .padding(.vertical, ODSSpacing.s)
        }
        .padding(.top, ODSSpacing.s)
    }
}
