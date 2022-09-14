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

public struct ODSCardImageFirstModel {
    public let title: String
    public let subtitle: String?
    public let image: Image
    public let supportingText: String?

    public init(title: String, subtitle: String? = nil, image: Image, supportingText: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.supportingText = supportingText
    }
}

public struct ODSCardImageFirst<ButtonContent1, ButtonContent2>: View where ButtonContent1: View, ButtonContent2: View {

    private var model: ODSCardImageFirstModel
    private var buttonContent1: () -> ButtonContent1
    private var buttonContent2: () -> ButtonContent2

    public init(model: ODSCardImageFirstModel,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1,
                @ViewBuilder buttonContent2: @escaping () -> ButtonContent2)
    {
        self.model = model
        self.buttonContent1 = buttonContent1
        self.buttonContent2 = buttonContent2
    }

    public var body: some View {

        VStack(alignment: .leading, spacing: ODSSpacing.none) {

            model.image
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                Text(model.title)
                    .odsFont(.bodyBold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if let subtitle = model.subtitle, !subtitle.isEmpty {
                    Text(subtitle)
                }
                if let supportingText = model.supportingText, !supportingText.isEmpty {
                    Text(supportingText)
                }
            }
            .foregroundColor(.primary)
            .padding(.horizontal, ODSSpacing.m)
            .padding(.top, ODSSpacing.m)

            // Add padding on buttons to avoid to have extra padding on
            // HStack even if there are no view on buttons.
            HStack(spacing: ODSSpacing.m) {
                buttonContent1().padding(.top, ODSSpacing.m)
                buttonContent2().padding(.top, ODSSpacing.m)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.bottom, ODSSpacing.m)
        }
        .background(ODSColor.componentBackground2.color)
        .cornerRadius(10)
        .shadow(radius: ODSSpacing.xs)
        .padding(.all, ODSSpacing.s)
    }
}

extension ODSCardImageFirst where ButtonContent2 == EmptyView {

    public init(model: ODSCardImageFirstModel,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1)
    {
        self.model = model
        self.buttonContent1 = buttonContent1
        buttonContent2 = { EmptyView() }
    }
}

extension ODSCardImageFirst where ButtonContent1 == EmptyView, ButtonContent2 == EmptyView {

    public init(model: ODSCardImageFirstModel) {
        self.model = model
        buttonContent1 = { EmptyView() }
        buttonContent2 = { EmptyView() }
    }
}

#if DEBUG
struct ODSCardImageFirst_Previews: PreviewProvider {

    struct ButtonAction: View {
        let text: String

        var body: some View {
            Button {} label: {
                ODSGenericButtonContent(topText: text, textColor: ODSColor.coreBlack.color)
            }
            .buttonStyle(ODSBorderedButtonStyle())
        }
    }

    static let model = ODSCardImageFirstModel(
        title: ODSCardModel.example.title,
        subtitle: ODSCardModel.example.subTitle,
        image: Image("ods_empty", bundle: Bundle.ods),
        supportingText: ODSCardModel.example.description)

    static var previews: some View {
        ScrollView {
            ODSCardImageFirst(model: ODSCardImageFirst_Previews.model) {
                ButtonAction(text: "Button 1")
            } buttonContent2: {
                ButtonAction(text: "Button 2")
            }
        }
    }
}
#endif
