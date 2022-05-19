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
                FullWidthImportantMainCallToAction()
                FullWidthFilled()
                FullWidthOutlined()
                ButtonList()

                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.navigationTitle("Button")
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))
            .navigationViewStyle(.stack)
    }
}

private struct FullWidthImportantMainCallToAction: View {

    var body: some View {

        Text("Important - Main call to action")
            .odsFont(style: .title2)
        VStack(alignment: .center) {
            Button {} label: {
                ODSGenericButtonContent(topText: "Button", textColor: .black)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ODSFilledButtonStyle())
        }.padding([.leading, .trailing], 45)
    }
}

private struct FullWidthFilled: View {

    var body: some View {

        Text("Filled")
            .odsFont(style: .title2)
        VStack(alignment: .center) {
            Button {} label: {
                ODSGenericButtonContent(topText: "Button", textColor: Color(UIColor.systemGray6))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ODSFilledButtonStyle(backgroundColor: Color(UIColor.label)))
        }.padding([.leading, .trailing], 45)
    }
}

private struct FullWidthOutlined: View {

    var body: some View {

        Text("Outlined")
            .odsFont(style: .title2)
        VStack(alignment: .center) {
            Button {} label: {
                ODSGenericButtonContent(topText: "Button", textColor: Color(UIColor.label))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ODSBorderedButtonStyle())
        }.padding([.leading, .trailing], 45)
    }
}

private struct ButtonList: View {

    var body: some View {
        Text("Button list :")
        ForEach(DemoButton.buttons, id: \.name) { button in

            Text(button.name)
                .odsFont(style: .title2)

            VStack(alignment: .center) {
                Button {} label: {
                    ODSGenericButtonContent(topText: "Button", textColor: button.textColor)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle(backgroundColor: button.BGColor)) // .buttonStyle(button.buttonStyle.style())
            }.padding([.leading, .trailing], 45)
        }
    }
}

// Need to use custom view modifier !

enum ODSButtonStyle {
    case filled
    case outlined

//    func style() -> ButtonStyle {
//        return ODSBorderedButtonStyle()
//    }
}

private struct DemoButton {
    let name: String
    let textColor: Color
    let BGColor: Color?
    let buttonStyle: ODSButtonStyle

    static var buttons: [DemoButton] { [
        DemoButton(name: "Important - Main call to action", textColor: Color(.black), BGColor: nil, buttonStyle: .filled),
        DemoButton(name: "Filled", textColor: Color(.systemGray6), BGColor: Color(.label), buttonStyle: .outlined),
        DemoButton(name: "Outlined", textColor: Color(.label), BGColor: nil, buttonStyle: .outlined),
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
