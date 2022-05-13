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

struct ShapeButton: View {

    let hPadding: CGFloat = 16.0
    var body: some View {
        ScrollView {
            Image("Shape_button")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: 20) {
                ComponentDescription(text: "A custom shape button allows ...")
                VariantsTitle()
                // StandardEditText()
                Spacer().frame(height: 10)
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        }.navigationTitle("Button")
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))

//        ScrollView {
//            let imageDescription = ODSImageDescription(image: Image(systemName: "checkmark.circle.fill"), imageWidth: 30, imageHeight: 30, foregroundColor: ODS.coreBlack)
//            let imageDescription2 = ODSImageDescription(image: Image(systemName: "checkmark.circle.fill"), imageWidth: 30, imageHeight: 30, foregroundColor: Color.primary)
//
//            // Filled buttons
//            Group {
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Added to Siri", bottomText: "Hello world", textColor: ODS.coreBlack)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world", textColor: ODS.coreBlack)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri", textColor: ODS.coreBlack)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//            }
//
//            // Not-filled buttons
//            Group {
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription2, topText: "Added to Siri", bottomText: "Hello world")
//                }
//                .buttonStyle(ODSBorderedButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world")
//                }
//                .buttonStyle(ODSBorderedButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri")
//                }
//                .buttonStyle(ODSBorderedButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription2)
//                }
//                .buttonStyle(ODSBorderedButtonStyle())
//                .padding(.horizontal, hPadding)
//            }
//
//            // Full width butons (filled)
//            Group {
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Added to Siri", bottomText: "Hello world", textColor: ODS.coreBlack)
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world", textColor: ODS.coreBlack)
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri", textColor: ODS.coreBlack)
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription)
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//            }
//
//            // Disabled buttons
//            Group {
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Added to Siri", bottomText: "Hello world")
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//                .disabled(true)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world")
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//                .disabled(true)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(topText: "Added to Siri")
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//                .disabled(true)
//
//                Button {
//                    print("Action")
//                } label: {
//                    ODSGenericButtonContent(imageDescription: imageDescription)
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(ODSFilledButtonStyle())
//                .padding(.horizontal, hPadding)
//                .disabled(true)
//            }
//        }.navigationTitle("Buttons")
            .navigationViewStyle(.stack)
    }
}
