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

struct TextButtonPage: View {

    var body: some View {
        ScrollView {
            Image("Text_button")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "Plain buttons are the most ubiquitous component found throughout applications. Consisting of either a text label or an icon, they are the most simple button style.")
                VariantsTitle()
                LabelButton()
                IconButton()
                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.navigationTitle("Text Buttons")
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))
    }
}

struct LabelButton: View {

    var body: some View {

        Text("Label")
            .odsFont(style: .title2)
        VStack(alignment: .center) {
            Button {} label: {
                ODSGenericButtonContent(topText: "Label button", textColor: ODS.coreOrange)
            }
        }.padding([.leading, .trailing], 45)
    }
}

struct IconButton: View {

    let imageDescriptionPlus = ODSImageDescription(image: Image(systemName: "plus.circle").renderingMode(.template), imageWidth: 30, imageHeight: 30, foregroundColor: ODS.coreOrange)

    var body: some View {
        Text("Icon")
            .odsFont(style: .title2)
        VStack(alignment: .center) {
            Button {} label: {
                ODSGenericButtonContent(imageDescription: imageDescriptionPlus)
            }
        }.padding([.leading, .trailing], 45)
    }
}
