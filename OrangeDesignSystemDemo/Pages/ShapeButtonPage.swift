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
            Image("Buttons - Shape")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "A custom shape button allows a user to perform an important call to action. This button that contains a text label and a supporting icon can be displayed")
                VariantsTitle()
                ButtonList()

                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.background(ODSColor.primaryBackground.color)
    }
}

private struct ButtonList: View {

    var body: some View {
        ForEach(DemoButton.buttons, id: \.order) { button in

            Text(button.name)
                .odsFont(style: .title2)

            VStack(alignment: .center) {
                Button {} label: {
                    ODSGenericButtonContent(
                        imageDescription: button.withIcon ? ODSImageDescription(image: Image(systemName: "plus").renderingMode(.template), imageWidth: 15, imageHeight: 15, foregroundColor: button.textColor) : nil,
                        topText: "Button",
                        textColor: button.textColor)
                        .frame(maxWidth: button.isFullWidth ? .infinity : nil)
                }
                .disabled(button.isDisabled)
                .frame(maxWidth: .infinity)
                .buttonStyle(ODSButtonStyle(borderColor: button.textColor, backgroundColor: button.BGColor, buttonType: button.buttonType))
                .padding([.bottom], 15)
            }.padding([.leading, .trailing], 45)
        }
    }
}

private struct DemoButton {
    let order: Int
    let name: String
    let textColor: Color
    let BGColor: Color?
    let buttonType: ButtonType
    let isFullWidth: Bool
    let withIcon: Bool
    let isDisabled: Bool

    public init(order: Int, name: String, textColor: Color, BGColor: Color? = nil, buttonType: ButtonType = .filled, isFullWidth: Bool = false, withIcon: Bool = false, isDisabled: Bool = false) {
        self.order = order
        self.name = name
        self.textColor = textColor
        self.BGColor = BGColor
        self.buttonType = buttonType
        self.isFullWidth = isFullWidth
        self.withIcon = withIcon
        self.isDisabled = isDisabled
    }

    static var buttons: [DemoButton] { [
        DemoButton(order: 1, name: "Important (full width)", textColor: Color(.black), isFullWidth: true),
        DemoButton(order: 2, name: "Filled", textColor: Color(.systemBackground), BGColor: Color(.label), isFullWidth: true),
        DemoButton(order: 3, name: "Outlined", textColor: Color(.label), buttonType: .bordered, isFullWidth: true),
        DemoButton(order: 4, name: "Important (variable width)", textColor: Color(.black)),
        DemoButton(order: 5, name: "Filled", textColor: Color(.systemBackground), BGColor: Color(.label)),
        DemoButton(order: 6, name: "Outlined", textColor: Color(.label), buttonType: .bordered),
        DemoButton(order: 7, name: "Negative", textColor: Color(.systemBackground), BGColor: ODS.functionalNegative, isFullWidth: true),
        DemoButton(order: 8, name: "Positive", textColor: Color(.systemBackground), BGColor: ODS.functionalPositive, isFullWidth: true),
        DemoButton(order: 9, name: "Important with icon (full width)", textColor: Color(.black), isFullWidth: true, withIcon: true),
        DemoButton(order: 10, name: "Filled", textColor: Color(.systemBackground), BGColor: Color(.label), isFullWidth: true, withIcon: true),
        DemoButton(order: 11, name: "Outlined", textColor: Color(.label), buttonType: .bordered, isFullWidth: true, withIcon: true),
        DemoButton(order: 12, name: "Important with icon (variable width)", textColor: Color(.black), withIcon: true),
        DemoButton(order: 13, name: "Filled", textColor: Color(.systemBackground), BGColor: Color(.label), withIcon: true),
        DemoButton(order: 14, name: "Outlined", textColor: Color(.label), buttonType: .bordered, withIcon: true),
        DemoButton(order: 15, name: "Important disabled", textColor: Color(.black), isFullWidth: true, isDisabled: true),
        DemoButton(order: 16, name: "Filled", textColor: Color(.systemBackground), BGColor: Color(.label), isFullWidth: true, isDisabled: true),
        DemoButton(order: 17, name: "Outlined", textColor: Color(.label), buttonType: .bordered, isFullWidth: true, isDisabled: true),
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
