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

struct CardViewDemoSandbox: View {
    @StateObject var example = ODSCardModel(title: ODSCardModel.example.title, image: ODSCardModel.example.image)
    @State var showReset = false
    @State var longText = false
    @State var hideSubtitle = true
    @State var hideDescription = true
    @State var showImage = false

    var body: some View {
        ScrollView {
            // let size = UIScreen.main.bounds.size.width / 2 - (ODSDim.padding * 2)
            VStack(alignment: .leading, spacing: 15) {

                /*** Card View */
                CardViewCustom(element: example) {

                    Group {
                        if showReset {
                            Spacer()
                            Button {
                                print("Reset")
                                showReset = false
                                longText = false
                                hideSubtitle = true
                                hideDescription = true
                                showImage = false
                            } label: {
                                ODSGenericButtonContent(topText: "Reset", textColor: ODSColor.coreBlack.color)
                            }
                            .buttonStyle(ODSFilledButtonStyle())
                        }
                    }
                }
                .onAppear {
                    // example = longText ? ODSCardModel.exampleMultiline : ODSCardModel.example
                    example.title = longText ? ODSCardModel.exampleMultiline.title : ODSCardModel.example.title
                }
                .padding()

                /*** Custom */
                VStack {
                    Toggle(isOn: $longText) {
                        Text("Replace with very long text").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)
                    }.onChange(of: longText) { _ in
                        print(longText)
                        example.title = longText ? ODSCardModel.exampleMultiline.title : ODSCardModel.example.title
                        example.subTitle = hideSubtitle ? "" : longText ? ODSCardModel.exampleMultiline.subTitle : ODSCardModel.example.subTitle
                        example.description = hideDescription ? "" : longText ? ODSCardModel.exampleMultiline.description : ODSCardModel.example.description
                    }
                    Toggle(isOn: $showReset) {
                        Text("Add reset button").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)
                    }
                    Toggle(isOn: $hideSubtitle) {
                        Text("Remove Subtitle").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)

                    }.onChange(of: hideSubtitle) { _ in
                        example.subTitle = hideSubtitle ? "" : longText ? ODSCardModel.exampleMultiline.subTitle : ODSCardModel.example.subTitle
                    }
                    Toggle(isOn: $hideDescription) {
                        Text("Remove Description").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)

                    }.onChange(of: hideDescription) { _ in
                        example.description = hideDescription ? "" : longText ? ODSCardModel.exampleMultiline.description : ODSCardModel.example.description
                    }
                    Toggle(isOn: $showImage) {
                        Text("Add top image").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)
                    }.onChange(of: showImage) { _ in
                        example.image = showImage ? "Card" : ""
                    }
                }.padding()
            }
            .background(Color(uiColor: .systemGray5))
            Spacer()

        }.navigationTitle("Card")
            .background(Color(uiColor: .systemGray5))
    }
}

#if DEBUG
struct CardViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemoSandbox()
            .previewInterfaceOrientation(.portrait)
        CardViewDemoSandbox()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3) // <- CONSTANT
    }
}
#endif
