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

/// Model used to configure the `ODSCardVerticalHeaderFirst` card.
public struct ODSCardVerticalHeaderFirstModel: Identifiable {
    let title: String
    let subtitle: String?
    let thumbnail: Image?
    let imageSource: ODSImage.Source
    let supportingText: String?

    /// Initilize the model
    ///
    /// - Parameters:
    ///  - title: The title to be displayed in the card.
    ///  - thumbnail: The optional thumbnail: avatar, logo or icon.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - imageSource: The image to be displayed in the card.
    ///  - supportingText Optional text description to be displayed in the card.
    ///
    public init(title: String,
                subtitle: String? = nil,
                thumbnail: Image? = nil,
                imageSource: ODSImage.Source,
                supportingText: String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
        self.imageSource = imageSource
        self.supportingText = supportingText
    }

    /// The identifier based on the title.
    public var id: String {
        title
    }
}

///
/// <a href="https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb" target="_blank">ODS Card</a>.
///
/// This is a full width card displayed with a title and a thumbnail on top as first element.
/// This card is composed of three parts:
/// - Header: with a title, an optinal subtitle and an optinal thmubnail
/// - Media: (today an image)
/// - Content: with an optinal supporting text and optional buttons (zero up to two)
///
/// The card is configured using the model `ODSCardVerticalHeaderFirstModel` and optional action buttons
/// can be provided through ViewBuilders `buttonContent1` and `buttonContent2`.
///
/// Those view builder are usefull to provide buttons managed somewhere else to handle actions, manage disable state, apply style,...
///
public struct ODSCardVerticalHeaderFirst<ButtonContent1, ButtonContent2>: View where ButtonContent1: View, ButtonContent2: View {

    private var buttonContent1: () -> ButtonContent1
    private var buttonContent2: () -> ButtonContent2
    private let model: ODSCardVerticalHeaderFirstModel

    /// Initialization with two buttons.
    ///
    /// - Parameters:
    ///  - model: The model to configure the card.
    ///  - buttonContent1: The button1 view builder
    ///  - buttonContent2: The button2 view builder
    ///
    public init(model: ODSCardVerticalHeaderFirstModel,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1,
                @ViewBuilder buttonContent2: @escaping () -> ButtonContent2)
    {
        self.model = model
        self.buttonContent1 = buttonContent1
        self.buttonContent2 = buttonContent2
    }
}

extension ODSCardVerticalHeaderFirst where ButtonContent2 == EmptyView {

    /// Initialization with one button.
    ///
    /// - Parameters:
    ///  - model: The model to configure the card.
    ///  - buttonContent1: The button1 view builder
    ///
    public init(model: ODSCardVerticalHeaderFirstModel,
                @ViewBuilder buttonContent1: @escaping () -> ButtonContent1)
    {
        self.model = model
        self.buttonContent1 = buttonContent1
        buttonContent2 = { EmptyView() }
    }
}

extension ODSCardVerticalHeaderFirst where ButtonContent1 == EmptyView, ButtonContent2 == EmptyView {

    /// Initialization without any button.
    ///
    /// - Parameter model: The model to configure the card.
    ///
    public init(model: ODSCardVerticalHeaderFirstModel) {
        self.model = model
        buttonContent1 = { EmptyView() }
        buttonContent2 = { EmptyView() }
    }
}

// MARK: View body implementation

extension ODSCardVerticalHeaderFirst {

    public var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.none) {
            HStack(alignment: .center, spacing: ODSSpacing.s) {
                model.thumbnail?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0, alignment: .center)
                    .clipShape(Circle())
                    .accessibilityHidden(true)

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
            .multilineTextAlignment(.leading)
            .foregroundColor(.primary)
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
            .layoutPriority(100)

            ODSImage(source: model.imageSource)
                .aspectRatio(contentMode: .fill)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                if let supportingText = model.supportingText, !supportingText.isEmpty {
                    Text(supportingText)
                        .odsFont(.bodyRegular)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, ODSSpacing.m)
                        .padding(.top, ODSSpacing.s)
                }

                // Add padding on buttons to avoid to have extra padding on
                // HStack even if there are no view on buttons.
                HStack(spacing: ODSSpacing.m) {
                    buttonContent1().padding(.top, ODSSpacing.m)
                    buttonContent2().padding(.top, ODSSpacing.m)
                }
                .padding(.horizontal, ODSSpacing.m)
            }
            .modifier(PaddingModifier())
        }
        .modifier(CardShadowModifier())
    }
}

// MARK: Padding modifier

private struct PaddingModifier: ViewModifier {
    @State private var height: CGFloat?

    private var bottomPadding: CGFloat {
        height == 0 ? ODSSpacing.none : ODSSpacing.m
    }

    private var topPadding: CGFloat {
        height == 0 ? ODSSpacing.none : ODSSpacing.xs
    }

    func body(content: Content) -> some View {
        content
            .readSize { size in
                print("size\(size.height)")
                height = size.height
            }
            .padding(.top, topPadding)
            .padding(.bottom, bottomPadding)
    }
}

// MARK: Previews
#if DEBUG
struct ODSCardVerticalHeaderFirst_Previews: PreviewProvider {

    struct Toast: View {
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
            ODSButton(text: LocalizedStringKey(text), emphasis: .highest, variableWidth: true, action: action)
        }
    }

    static let model = ODSCardVerticalHeaderFirstModel(
        title: ODSCCardPreviewData.title,
        subtitle: ODSCCardPreviewData.subtitle,
        thumbnail: ODSCCardPreviewData.thumbnail,
        imageSource: .image(ODSCCardPreviewData.image),
        supportingText: ODSCCardPreviewData.supportingText)

    struct TestView: View {
        @State var showTextInToast: String?
        @State var disableButton1 = false

        var body: some View {
            ScrollView {
                ODSCardVerticalHeaderFirst(model: ODSCardVerticalHeaderFirst_Previews.model) {
                    ButtonAction(text: "Button 1") {
                        showTextInToast = "Button 1 Clicked"
                    }
                    .disabled(disableButton1)
                } buttonContent2: {
                    ButtonAction(text: "\(disableButton1 ? "Enable" : "Disable") Button 1") {
                        disableButton1.toggle()
                    }
                }
                .onTapGesture {
                    showTextInToast = "Card tapped"
                }

                Toast(showText: $showTextInToast)
            }
        }
    }

    static var previews: some View {
        TestView()
    }
}
#endif
