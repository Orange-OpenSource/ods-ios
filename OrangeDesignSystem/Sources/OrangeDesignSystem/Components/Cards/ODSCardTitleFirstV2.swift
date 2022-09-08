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

import SwiftUI

public typealias ButtonActionDescription = (text: String, onClicked: () -> Void)

public struct ODSCardTitleFirstV2: View {

    private let title: String
    private let subtitle: String?
    private let thumbnail: Image?
    private let description: String?
    private let image: Image
    private let button1Description: ButtonActionDescription?
    private let button2Description: ButtonActionDescription?

    public init(title: String,
                subtitle: String? = nil,
                thumbnail: Image? = nil,
                image: Image,
                description: String? = nil,
                button1Description: ButtonActionDescription? = nil,
                button2Description: ButtonActionDescription? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
        self.image = image
        self.description = description
        self.button1Description = button1Description
        self.button2Description = button2Description
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.none) {
            HStack(alignment: .center, spacing: ODSSpacing.s) {
                thumbnail?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0, alignment: .center)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: ODSSpacing.none) {
                    Text(title)
                        .odsFont(.bodyBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let subtitle = self.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .odsFont(.bodyRegular)
                    }
                }
            }
            .foregroundColor(.primary)
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
            .layoutPriority(100)

            image
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                if let description = self.description, !description.isEmpty {
                    Text(description)
                        .padding(.horizontal, ODSSpacing.m)
                }

                if button1Description != nil && button2Description != nil {
                    HStack(spacing: ODSSpacing.m) {
                        if let button1Description = self.button1Description {
                            ButtonAction(description: button1Description)
                        }
                        if let button2Description = self.button2Description {
                            ButtonAction(description: button2Description)
                        }
                    }
                    .padding(.horizontal, ODSSpacing.m)
                }
            }
            .padding(.top, ODSSpacing.xs)
            .padding(.bottom, ODSSpacing.m)
        }
        .background(ODSColor.componentBackground2.color)
        .cornerRadius(10)
        .shadow(radius: 8)
        .padding()
    }
}

struct ButtonAction: View {
    let description: ButtonActionDescription

    var body: some View {
        Button {
            description.onClicked()
        } label: {
            ODSGenericButtonContent(topText: description.text, textColor: ODSColor.coreBlack.color)
        }
        .buttonStyle(ODSBorderedButtonStyle())
    }
}

#if DEBUG
struct ODSCardTitleFirstV2_Previews: PreviewProvider {

    struct Tost: View {
        @Binding var showText: String?

        var body: some View {
            if let showText = self.showText {
                Text(showText)
                    .padding().background(.gray).clipShape(Capsule())
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.showText = nil
                        }
                    }
            }
        }
    }

    struct TestView: View {
        @State var showTextInTost: String?

        var body: some View {
            ScrollView {
                ODSCardTitleFirstV2(title: ODSCardModel.example.title,
                                    subtitle: ODSCardModel.example.subTitle,
                                    thumbnail: Image("ods_empty", bundle: Bundle.ods),
                                    image: Image("ods_empty", bundle: Bundle.ods),
                                    description: ODSCardModel.example.description,
                                    button1Description: (text: "Button 1", { showTextInTost = "Button 1 Clicked" }),
                                    button2Description: (text: "Button 2", { showTextInTost = "Button 2 Clicked" }))
                    .onTapGesture {
                        showTextInTost = "Card tapped"
                    }

                Tost(showText: $showTextInTost)
            }
        }
    }

    static var previews: some View {
        TestView()
    }
}
#endif
