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

public struct ODSCardTitleFirstModel: Identifiable {
    let title: String
    let subtitle: String?
    let thumbnail: Image?
    let image: Image
    let supportingText: String?

    public init(title: String, subtitle: String? = nil, thumbnail: Image? = nil, image: Image, supportingText: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
        self.supportingText = supportingText
        self.image = image
    }

    public var id: String {
        title
    }
}

public struct ODSCardTitleFirst<ButtonContent1, ButtonContent2>: View where ButtonContent1: View, ButtonContent2: View {

    private var buttonContent1: () -> ButtonContent1
    private var buttonContent2: () -> ButtonContent2

    let model: ODSCardTitleFirstModel

    public init(model: ODSCardTitleFirstModel,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1,
                @ViewBuilder buttonContent2: @escaping () -> ButtonContent2)
    {
        self.model = model
        self.buttonContent1 = buttonContent1
        self.buttonContent2 = buttonContent2
    }
}

extension ODSCardTitleFirst where ButtonContent2 == EmptyView {

    public init(model: ODSCardTitleFirstModel,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1)
    {
        self.model = model
        self.buttonContent1 = buttonContent1
        buttonContent2 = { EmptyView() }
    }
}

extension ODSCardTitleFirst where ButtonContent1 == EmptyView, ButtonContent2 == EmptyView {

    public init(model: ODSCardTitleFirstModel) {
        self.model = model
        buttonContent1 = { EmptyView() }
        buttonContent2 = { EmptyView() }
    }
}

extension ODSCardTitleFirst {

    public var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.none) {
            HStack(alignment: .center, spacing: ODSSpacing.s) {
                model.thumbnail?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0, alignment: .center)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: ODSSpacing.none) {
                    Text(model.title)
                        .odsFont(.bodyBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let subtitle = model.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .odsFont(.bodyRegular)
                    }
                }
            }
            .foregroundColor(.primary)
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
            .layoutPriority(100)

            model.image
                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                if let supportingText = model.supportingText, !supportingText.isEmpty {
                    Text(supportingText)
                        .padding(.horizontal, ODSSpacing.m)
                }

                // Add padding on buttons to avoid to have extra padding on
                // HStack even if there are no view on buttons.
                HStack(spacing: ODSSpacing.m) {
                    buttonContent1().padding(.top, ODSSpacing.m)
                    buttonContent2().padding(.top, ODSSpacing.m)
                }
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.top, ODSSpacing.xs)
            .padding(.bottom, ODSSpacing.m)
        }
        .background(ODSColor.componentBackground2.color)
        .cornerRadius(10)
        .shadow(radius: ODSSpacing.xs)
        .padding(.all, ODSSpacing.s)
    }
}

#if DEBUG
struct ODSCardTitleFirst_Previews: PreviewProvider {

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

    struct ButtonAction: View {
        let text: String
        let action: () -> Void

        var body: some View {
            Button {
                action()
            } label: {
                ODSGenericButtonContent(topText: text, textColor: ODSColor.coreBlack.color)
            }
            .buttonStyle(ODSBorderedButtonStyle())
        }
    }

    static let model = ODSCardTitleFirstModel(
        title: ODSCardModel.example.title,
        subtitle: ODSCardModel.example.subTitle,
        thumbnail: Image("ods_empty", bundle: Bundle.ods),
        image: Image("ods_empty", bundle: Bundle.ods),
        supportingText: ODSCardModel.example.description)

    struct TestView: View {
        @State var showTextInTost: String?
        @State var disableButton1: Bool = false

        var body: some View {
            ScrollView {
                ODSCardTitleFirst(model: ODSCardTitleFirst_Previews.model) {
                    ButtonAction(text: "Button 1") {
                        showTextInTost = "Button 1 Clicked"
                    }
                    .disabled(disableButton1)
                } buttonContent2: {
                    ButtonAction(text: "\(disableButton1 ? "Enable" : "Disable") Button 1") {
                        disableButton1.toggle()
                    }
                }
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
