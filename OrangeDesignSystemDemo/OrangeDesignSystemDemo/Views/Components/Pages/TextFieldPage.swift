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

struct TextFieldComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Text field"
        image = Image("Text edit menu")
        description = "The text field component comprises the text field itself, text selection and the edit menu. Some elements are styled and some are native."
        
        variants = AnyView(TextFieldVariants())
    }
}

struct TextFieldVariants: View {
    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            VariantTextField(type: .standard, title: "Standard text field", defaultTextToEdit: "text to edit")
            VariantTextField(type: .secure, title: "Secure text field", defaultTextToEdit: "secure text to edit")
            VariantTextEditor().padding(.bottom, ODSSpacing.s)
            VariantTextAutocapitalization(style: .characters)
            VariantTextAutocapitalization(style: .words)
            VariantTextAutocapitalization(style: .sentences)
        }
    }
}

struct VariantTextEditor: View {
    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VariantTextField(type: .textEditor, title: "Text editor")
    }
}

struct VariantTextAutocapitalization: View {
    let style: AutocapitalizationType

    var body: some View {
        VariantTextField(type: .autocapitalization, title: "Text field with autocapitalization (\(style.description))", defaultTextToEdit: "capitalized text to edit", autocapitalizationStyle: style.textInputAutocapitalization)
    }
}

private enum TextFieldType {
    case standard
    case secure
    case textEditor
    case autocapitalization
}

private struct VariantTextField: View {
    @State private var textToEdit: String = ""
    @State private var textEditorToEdit: String = "A text editor view allows you to display and edit multiline, scrollable text in your app’s user interface. \nBy default, the text editor view styles the text using characteristics inherited from the environment, like font(_:), foregroundColor(_:), and multilineTextAlignment(_:)"

    private let title: String
    private let textFieldType: TextFieldType
    private let defaultTextToEdit: String
    private let autocapitalizationStyle: TextInputAutocapitalization

    public init(type: TextFieldType, title: String, defaultTextToEdit: String = "", autocapitalizationStyle: TextInputAutocapitalization = .never) {
        textFieldType = type
        self.title = title
        self.autocapitalizationStyle = autocapitalizationStyle
        self.defaultTextToEdit = defaultTextToEdit
    }

    var body: some View {
        VStack {
            Text(title)
                .odsFont(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            switch textFieldType {
            case .standard:
                TextField(defaultTextToEdit, text: $textToEdit)
                    .customStyle()
            case .secure:
                SecureField(defaultTextToEdit, text: $textToEdit)
                    .customStyle()
            case .textEditor:
                TextEditor(text: $textEditorToEdit)
                    .customStyle()
            case .autocapitalization:
                TextField(defaultTextToEdit, text: $textToEdit)
                    .textInputAutocapitalization(autocapitalizationStyle)
                    .customStyle()
            }
        }
    }
}

enum AutocapitalizationType {
    case never
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
        case .never: return "never"
        case .characters: return "characters"
        case .words: return "words"
        case .sentences: return "sentences"
        }
    }
}

struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, ODSSpacing.m)
            .odsFont(.headline)
            .background(Color(.systemGray6))
            .overlay(RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(Color(.systemGray2), lineWidth: 1.0))
    }
}

extension View {
    func customStyle() -> some View {
        modifier(CustomTextFieldStyle())
    }
}

#if DEBUG
import OrangeTheme

struct TextFieldPage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            List {
                TextFieldVariants()
            }
            .environment(\.theme, OrangeThemeFactory().theme)
            .preferredColorScheme($0)
        }
    }
}
#endif

