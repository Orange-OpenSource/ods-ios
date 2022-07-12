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

import Foundation
import OrangeDesignSystem
import SwiftUI

struct TextSelectionPage: View {
    var body: some View {
        ScrollView {
            Image("Text edit menu")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "Text Selection is the selection of textual areas leading to the display of buttons allowing interaction")
                VariantsTitle()
                TextSelectionInTextField()
                TextSelectionInTextEditor()
                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.background(ODSColor.primaryBackground.color)
    }
}

struct TextSelectionInTextField: View {
    @State private var textToEdit: String = "Text selection in a text field"

    var body: some View {
        VStack {
            Text("Text selection in text field")
                .odsFont(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("A text field", text: $textToEdit)
                .padding(.horizontal, 20)
                .odsFont(.title3)
                .background(Color(.systemGray6))
                .overlay(Rectangle().stroke(Color(.systemGray2), lineWidth: 1.0))
        }
    }
}

struct TextSelectionInTextEditor: View {
    @State private var textToEdit: String = "Text selection in a text editor.\nA text editor view allows you to display and edit multiline, scrollable text in your app’s user interface. By default, the text editor view styles the text using characteristics inherited from the environment, like font(_:), foregroundColor(_:), and multilineTextAlignment(_:)"

    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack {
            Text("Text selection in text editor")
                .odsFont(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextEditor(text: $textToEdit)
                .padding(.horizontal, 20)
                .odsFont(.headline)
                .background(Color(.systemGray6))
                .overlay(Rectangle().stroke(Color(.systemGray2), lineWidth: 1.0))
        }
    }
}

struct EditText_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TextSelectionPage()
                .preferredColorScheme($0)
        }
    }
}
