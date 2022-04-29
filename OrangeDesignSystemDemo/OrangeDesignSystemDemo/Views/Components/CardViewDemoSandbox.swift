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
    @State var showImage = false
    @State var showSubtitle = false
    @State var showDescription = false
    @State var showButton = false

    private func resetSwitches() {
        showImage = false
        showSubtitle = false
        showDescription = false
        showButton = false
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {

                /*** Card View */
                CardViewCustom(element: example) {

                    Group {
                        if showButton {
                            Spacer()
                            Button {} label: {
                                ODSGenericButtonContent(topText: "Button", textColor: ODSColor.coreBlack.color)
                            }
                            .buttonStyle(ODSFilledButtonStyle())
                        }
                    }
                }
                .onAppear {
                    example.title = ODSCardModel.example.title
                }
                .padding()

                /*** Custom */
                VStack {
                    Toggle(isOn: $showImage) {
                        Text("Show image").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)
                    }.onChange(of: showImage) { _ in
                        example.image = showImage ? "Card" : ""
                    }

                    Toggle(isOn: $showSubtitle) {
                        Text("Show subtitle").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)
                    }.onChange(of: showSubtitle) { _ in
                        example.subTitle = showSubtitle ? ODSCardModel.example.subTitle : ""
                    }

                    Toggle(isOn: $showDescription) {
                        Text("Show description").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)

                    }.onChange(of: showDescription) { _ in
                        example.description = showDescription ? ODSCardModel.example.description : ""
                    }

                    Toggle(isOn: $showButton) {
                        Text("Show button").font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(.primary)
                    }

                    Spacer().frame(height: 30)

                    Button {
                        resetSwitches()
                    } label: {
                        ODSGenericButtonContent(topText: "Reset", textColor: ODS.coreBlack)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(ODSFilledButtonStyle())

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
