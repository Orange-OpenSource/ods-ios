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

struct CardPage: View {
    @State var showImage = false
    @State var showSubtitle = false
    @State var showDescription = false
    @State var showButton = false

    @State var colorScheme = 0

    private func resetSwitches() {
        showImage = false
        showSubtitle = false
        showDescription = false
        showButton = false
    }

    var example: ODSCardModel {
        ODSCardModel(
            title: "Title",
            image: showImage ? "Cards" : "",
            subTitle: showSubtitle ? ODSCardModel.example.subTitle : "",
            description: showDescription ? ODSCardModel.example.description : "")
    }

    var body: some View {
        ScrollView {
            Image("Cards_1")
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: 20) {

                ComponentDescription(text: "Cards are a contained and independent element that can display content and actions on a single topic.")
                VariantsTitle()

                // Card demonstrator
                CardViewCustom(element: example) {
                    if showButton {
                        Button {} label: {
                            ODSGenericButtonContent(topText: "Button", textColor: ODSColor.coreBlack.color)
                        }
                        .buttonStyle(ODSFilledButtonStyle())
                    }
                }
                .padding()

                // Controls
                VStack {
                    Toggle(isOn: $showImage) {
                        Text("Show image")
                    }
                    .toggleStyle(.button)
                    .buttonStyle(.bordered)

                    Toggle(isOn: $showSubtitle) {
                        Text("Show subtitle")
                    }

                    Toggle(isOn: $showDescription) {
                        Text("Show description")
                    }

                    Toggle(isOn: $showButton) {
                        Text("Show button")
                    }

                    Spacer().frame(height: 30)

                    Button {
                        resetSwitches()
                    } label: {
                        ODSGenericButtonContent(topText: "Reset", textColor: ODS.coreBlack)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(ODSFilledButtonStyle())
                }
                .padding()
                .font(ODSFontStyle.bodyRegular.font())
                .foregroundColor(.primary)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.background(ODSColor.primaryBackground.color)
    }
}

#if DEBUG
struct CardViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardPage()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            CardPage()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
