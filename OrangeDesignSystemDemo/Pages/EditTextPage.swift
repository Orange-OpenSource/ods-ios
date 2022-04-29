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

import Combine
import Foundation
import OrangeDesignSystem
import SwiftUI

struct EditTextPage: View {

    var body: some View {
        ScrollView {
            Image("Controls")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "Edit text is the selection of textual areas leading to the display of buttons allowing interaction")
                VariantsTitle()
                StandardEditText()
                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.navigationTitle("Edit Text")
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))
    }
}

struct EditText_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            EditTextPage()
                .preferredColorScheme($0)
        }
    }
}

struct StandardEditText: View {

    @State private var textToEdit: String = "This is some editable text..."
    @FocusState private var isFocused: Bool

    var body: some View {

        VStack {
            TextField("A text field", text: $textToEdit)
                .focused($isFocused, equals: true)
                .padding(.horizontal, 20)
                .font(ODSFontStyle.headline.font())
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isFocused = true
                    }
                }
        }
    }
}
