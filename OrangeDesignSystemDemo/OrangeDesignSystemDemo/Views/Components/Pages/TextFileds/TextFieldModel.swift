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

class VariantTextFieldModel: ObservableObject {
    
    // ====================
    // MARK: Internal types
    // ====================

    enum CapitalizationType: Int, CaseIterable {
        case never = 0
        case characters
        case words
        case sentences
        
        public var textInputAutocapitalization: TextInputAutocapitalization {
            switch self {
            case .never: return .never
            case .characters: return .characters
            case .words: return .words
            case .sentences: return .sentences
            }
        }
        
        public var description: String {
            switch self {
            case .never: return "none"
            case .characters: return "characters"
            case .words: return "words"
            case .sentences: return "sentences"
            }
        }
    }
    
    enum TextInputType {
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
        return "text to edit"
    }
    
    let capitalizationTypeChips: [ODSChip<CapitalizationType>]
    let textInputType: TextInputType
    
    // ==================
    // MARK: Initializers
    // ==================

    init(textInputType: TextInputType) {
        
        self.textInputType = textInputType
        
        capitalizationTypeChips = CapitalizationType.allCases.map { type in
            ODSChip(type, text: type.description)
        }
        selectedCapitalizationType = CapitalizationType.never
        
        reseetTextToEdit()
    }
    
    private func reseetTextToEdit() {
        switch textInputType {
        case .textField:
            textToEdit = ""
        case .textEditor:
            textToEdit = "text to edit"
        }
    }
}
