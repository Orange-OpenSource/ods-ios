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

public struct ODSCardTitleFirstElement {
    let title: String
    let subtitle: String?
    let thumbnail: Image?
    let image: Image
    let description: String?

    public init(title: String, subtitle: String? = nil, thumbnail: Image? = nil, image: Image, description: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
        self.description = description
        self.image = image
    }
}

public struct ODSCardTitleFirst<ButtonContent1, ButtonContent2>: View where ButtonContent1: View, ButtonContent2: View {

    private var buttonContent1: () -> ButtonContent1
    private var buttonContent2: () -> ButtonContent2

    let element: ODSCardTitleFirstElement

    public init(element: ODSCardTitleFirstElement,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1,
                @ViewBuilder buttonContent2: @escaping () -> ButtonContent2)
    {
        self.element = element
        self.buttonContent1 = buttonContent1
        self.buttonContent2 = buttonContent2
    }
}

extension ODSCardTitleFirst where ButtonContent2 == EmptyView {

    public init(element: ODSCardTitleFirstElement,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1)
    {
        self.element = element
        self.buttonContent1 = buttonContent1
        buttonContent2 = { EmptyView() }
    }
}

extension ODSCardTitleFirst where ButtonContent1 == EmptyView, ButtonContent2 == EmptyView {

    public init(element: ODSCardTitleFirstElement) {
        self.element = element
        buttonContent1 = { EmptyView() }
        buttonContent2 = { EmptyView() }
    }
}

extension ODSCardTitleFirst {

    public var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.none) {
            HStack(alignment: .center, spacing: ODSSpacing.s) {
                element.thumbnail?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0, alignment: .center)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: ODSSpacing.none) {
                    Text(element.title)
                        .odsFont(.bodyBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let subtitle = element.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .odsFont(.bodyRegular)
                    }
                }
            }
            .foregroundColor(.primary)
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
            .layoutPriority(100)

            element.image
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                if let description = element.description, !description.isEmpty {
                    Text(description)
                        .padding(.horizontal, ODSSpacing.m)
                }

                HStack(spacing: ODSSpacing.m) {
                    buttonContent1()
                    buttonContent2()
                }
                .padding(.horizontal, ODSSpacing.m)
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

#if DEBUG
struct ODSCardTitleFirst_Previews: PreviewProvider {

    struct ButtonAction: View {
        let text: String

        var body: some View {
            Button {} label: {
                ODSGenericButtonContent(topText: text, textColor: ODSColor.coreBlack.color)
            }
            .buttonStyle(ODSBorderedButtonStyle())
        }
    }

    static let element = ODSCardTitleFirstElement(
        title: ODSCardModel.example.title,
        subtitle: ODSCardModel.example.subTitle,
        thumbnail: Image("ods_empty", bundle: Bundle.ods),
        image: Image("ods_empty", bundle: Bundle.ods),
        description: ODSCardModel.example.description)

    static var previews: some View {
        ScrollView {
            ODSCardTitleFirst(element: ODSCardTitleFirst_Previews.element) {
                ButtonAction(text: "Button 1")
            } buttonContent2: {
                ButtonAction(text: "Button 2")
            }
        }
    }
}
#endif
