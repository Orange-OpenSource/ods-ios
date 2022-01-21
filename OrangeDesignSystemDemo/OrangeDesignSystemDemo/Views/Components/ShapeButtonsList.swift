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

struct ShapeButtonsList: View {

    let hPadding: CGFloat = 16.0
    var body: some View {
        ScrollView {
            let imageDescription = ODSImageDescription(image: Image(systemName: "checkmark.circle.fill"), imageWidth: 30, imageHeight: 30)
            Group {
                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Added to Siri", bottomText: "Hello world", textColor: ODSColor.core_black_900.color)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world", textColor: ODSColor.core_black_900.color)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri", textColor: ODSColor.core_black_900.color)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)
            }

            Group {
                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Added to Siri", bottomText: "Hello world")
                }
                .buttonStyle(ODSBorderedButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world")
                }
                .buttonStyle(ODSBorderedButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri")
                }
                .buttonStyle(ODSBorderedButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription)
                }
                .buttonStyle(ODSBorderedButtonStyle())
                .padding(.horizontal, hPadding)
            }

            Group {
                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Added to Siri", bottomText: "Hello world", textColor: ODSColor.core_black_900.color)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world", textColor: ODSColor.core_black_900.color)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri", textColor: ODSColor.core_black_900.color)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)
            }

            Group {
                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription, topText: "Added to Siri", bottomText: "Hello world")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)
                .disabled(true)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri", bottomText: "Hello world")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)
                .disabled(true)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(topText: "Added to Siri")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)
                .disabled(true)

                Button {
                    print("Action")
                } label: {
                    ODSGenericButtonContent(imageDescription: imageDescription)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(ODSFilledButtonStyle())
                .padding(.horizontal, hPadding)
                .disabled(true)
            }
        }
    }
}
