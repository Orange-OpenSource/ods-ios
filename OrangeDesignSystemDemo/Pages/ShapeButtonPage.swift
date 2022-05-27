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

struct ShapeButtonPage: View {

    let hPadding: CGFloat = 16.0
    var body: some View {
        ScrollView {
            Image("Shape_button")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "A custom shape button allows a user to perform an important call to action. This button that contains a text label and a supporting icon can be displayed")
                VariantsTitle()
                ButtonList()

                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.navigationTitle("Button")
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))
            .navigationViewStyle(.stack)
    }
}

private struct ButtonList: View {

    var body: some View {
        ForEach(DemoButton.buttons, id: \.order) { button in

            Text(button.name)
                .odsFont(style: .title2)

            VStack(alignment: .center) {
                HStack {
                    Button {} label: {
                        ODSGenericButtonContent(topText: "Button", textColor: button.textColor)
                            .frame(maxWidth: button.isFullWidth ? .infinity : nil)
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(ODSButtonStyle(backgroundColor: button.BGColor, isFilled: button.isFilled))
                }
            }.padding([.leading, .trailing], 45)
        }
    }
}

private struct DemoButton {
    let order: Int
    let name: String
    let textColor: Color
    let BGColor: Color?
    let isFilled: Bool
    let isFullWidth: Bool

    static var buttons: [DemoButton] { [
        DemoButton(order: 1, name: "Important - Main call to action (full width)", textColor: Color(.black), BGColor: nil, isFilled: true, isFullWidth: true),
        DemoButton(order: 2, name: "Filled", textColor: Color(.systemBackground), BGColor: Color(.label), isFilled: true, isFullWidth: true),
        DemoButton(order: 3, name: "Outlined", textColor: Color(.label), BGColor: nil, isFilled: false, isFullWidth: true),
        DemoButton(order: 4, name: "Important - Main call to action (width adapted to the content)", textColor: Color(.black), BGColor: nil, isFilled: true, isFullWidth: false),
        DemoButton(order: 5, name: "Filled", textColor: Color(.systemBackground), BGColor: Color(.label), isFilled: true, isFullWidth: false),
        DemoButton(order: 6, name: "Outlined", textColor: Color(.label), BGColor: nil, isFilled: false, isFullWidth: false),
        DemoButton(order: 7, name: "Negative", textColor: Color(.systemBackground), BGColor: ODS.functionalNegative, isFilled: true, isFullWidth: true),
        DemoButton(order: 8, name: "Positive", textColor: Color(.systemBackground), BGColor: ODS.functionalPositive, isFilled: true, isFullWidth: true),
    ]
    }
}

struct ShapeButtonPage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ShapeButtonPage()
                .preferredColorScheme($0)
        }
    }
}
