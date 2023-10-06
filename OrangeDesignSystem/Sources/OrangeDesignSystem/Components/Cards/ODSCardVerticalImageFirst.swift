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

import SwiftUI

/// Model used to configure the `ODSCardVerticalImageFirst` card.
//public struct ODSCardVerticalImageFirstModel: Identifiable {
//    let title: String
//    let subtitle: String?
//    let imageSource: ODSImage.Source
//    let supportingText: String?
//
//  
//    /// The identifier based on the title.
//    public var id: String {
//        title
//    }
//}

///
/// <a href="https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb" target="_blank">ODS Card</a>.
///
/// This is a full width card displayed with an image as first element.
/// This card is composed of two parts:
/// - Media: (today an image)
/// - Content: with a title, an optional subtitle, an optional supporting text and optional buttons (zero up to two)
///
/// The card is configured using the model `ODSCardVerticalImageFirstModel` and optional action buttons
/// can be provided through ViewBuilders `buttonContent1` and `buttonContent2`.
///
/// Those view builders are usefull to provide buttons managed somewhere else to handle actions, manage disable state, apply style,...
///
public struct ODSCardVerticalImageFirst: View {

    private let title: Text
    private let subtitle: Text?
    private let imageSource: ODSImage.Source
    private let text: Text?
    private let firstButton: (() -> Button<Text>)?
    private let secondButton: (() -> Button<Text>)?

    /// Initialization without button
    ///
    /// - Parameters:
    ///  - title: The title to be displayed in the card.
    ///  - imageSource: The image to be displayed in the card.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - text: Optional text description to be displayed in the card.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        text: Text? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.text = text
        self.firstButton = nil
        self.secondButton = nil
    }

    /// Initialization with one button.
    ///
    /// - Parameters:
    ///  - title: The title to be displayed in the card.
    ///  - imageSource: The image to be displayed in the card.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - text: Optional text description to be displayed in the card.
    ///  - button: The optional button.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        text: Text? = nil,
        @ViewBuilder button: @escaping () -> Button<Text>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.text = text
        self.firstButton = button
        self.secondButton = nil
    }

    /// Initialization with two buttons.
    ///
    /// - Parameters:
    ///  - title: The title to be displayed in the card.
    ///  - imageSource: The image to be displayed in the card.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - text: Optional text description to be displayed in the card.
    ///  - firstButton: The optional first (leading) button.
    ///  - secondButton: The optional second (trailing) button.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        text: Text? = nil,
        @ViewBuilder firstButton: @escaping () -> Button<Text>,
        @ViewBuilder secondButton: @escaping () -> Button<Text>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.text = text
        self.firstButton = firstButton
        self.secondButton = secondButton
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {

        VStack(alignment: .leading, spacing: ODSSpacing.none) {
            Group {
                ODSImage(source: imageSource)
                    .aspectRatio(contentMode: .fill)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                    title
                        .odsFont(.bodyBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                        subtitle?
                        .frame(maxWidth: .infinity, alignment: .leading)

                        text?
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundColor(.primary)
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
                .padding(.bottom, firstButton == nil ? ODSSpacing.m : ODSSpacing.none)
            }
            .multilineTextAlignment(.leading)

            buttons()
        }
        .modifier(CardShadowModifier())
    }

    // =====================
    // MARK: Private Helpers
    // =====================

    @ViewBuilder
    private func buttons() -> some View {
        if let firstButton = firstButton {
            HStack(alignment: .center, spacing: ODSSpacing.none) {
                firstButton()
                    .odsEmphasisButtonStyle(emphasis: .lowest)
                secondButton?()
                    .odsEmphasisButtonStyle(emphasis: .lowest)

                Spacer()
            }
        }
    }
}

// MARK: Previews
#if DEBUG
struct ODSCardVerticalImageFirst_Previews: PreviewProvider {

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


    struct TestView: View {
        @State var showTextInToast: String?

        var body: some View {
            ScrollView {
                ODSCardVerticalImageFirst(
                    title: Text(ODSCCardPreviewData.title),
                    imageSource: .image(ODSCCardPreviewData.image),
                    subtitle: Text(ODSCCardPreviewData.subtitle),
                    text: Text(ODSCCardPreviewData.supportingText)
                ) {
                    Button("Button 1") {
                        showTextInToast = "Button 1 Clicked"
                    }
                } secondButton: {
                    Button("Button 2") {
                        showTextInToast = "Button 2 Clicked"
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
