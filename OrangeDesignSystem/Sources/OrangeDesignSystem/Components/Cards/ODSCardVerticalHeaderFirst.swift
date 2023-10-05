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

///
/// <a href="https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb" target="_blank">ODS Card</a>.
///
/// This is a full width card displayed with a title and a thumbnail on top as first element.
/// This card is composed of three parts:
/// - Header: with a title, an optional subtitle and an optional thmubnail
/// - Media: (today an image)
/// - Content: with an optional text and optional buttons (zero up to two)
///
public struct ODSCardVerticalHeaderFirst: View {

    private let title: Text
    private let subtitle: Text?
    private let thumbnail: Image?
    private let imageSource: ODSImage.Source
    private let text: Text?
    private let firstButton: (() -> Button<Text>)?
    private let secondButton: (() -> Button<Text>)?

    // =================
    // MARK: Initializer
    // =================

    /// Initialization without button.
    ///
    /// - Parameters:
    ///  - title: The title to be displayed in the card.
    ///  - imageSource: The image to be displayed in the card.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - thumbnail: The optional thumbnail: avatar, logo or icon.
    ///  - text: Optional text description to be displayed in the card.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text?,
        thumbnail: Image?,
        text: Text? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
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
    ///  - thumbnail: The optional thumbnail: avatar, logo or icon.
    ///  - text: Optional text description to be displayed in the card.
    ///  - button: The optional button.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text?,
        thumbnail: Image?,
        text: Text? = nil,
        @ViewBuilder button: @escaping () -> Button<Text>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
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
    ///  - thumbnail: The optional thumbnail: avatar, logo or icon.
    ///  - text: Optional text description to be displayed in the card.
    ///  - firstButton: The optional first (leading) button.
    ///  - secondButton: The optional second (trailing) button.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        thumbnail: Image? = nil,
        text: Text? = nil,
        dividerEnabled: Bool = true,
        @ViewBuilder firstButton: @escaping () -> Button<Text>,
        @ViewBuilder secondButton: @escaping () -> Button<Text>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.thumbnail = thumbnail
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
            HStack(alignment: .center, spacing: ODSSpacing.s) {
                thumbnail?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44.0, height: 44.0, alignment: .center)
                    .clipShape(Circle())
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: ODSSpacing.none) {
                    title
                        .odsFont(.bodyBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    subtitle?
                        .odsFont(.bodyRegular)
                }
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.primary)
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
            .layoutPriority(100)

            ODSImage(source: imageSource)
                .aspectRatio(contentMode: .fill)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                text?
                    .odsFont(.bodyRegular)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.top, ODSSpacing.s)
                    .padding(.bottom, firstButton == nil ? ODSSpacing.m : ODSSpacing.none)
            }

            buttons()
        }
        .modifier(CardShadowModifier())
    }

    // =====================
    // MARK: Private Helpers
    // =====================

    private var image: some View {
        ODSImage(source: imageSource)
            .accessibilityHidden(true)
            .frame(width: 128)
            .clipped()
    }

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

    struct TestView: View {
        @State var showTextInToast: String?
        @State var disableButton1 = false

        var body: some View {
            ScrollView {
                ODSCardVerticalHeaderFirst(
                    title: Text(ODSCCardPreviewData.title),
                    imageSource: .image(ODSCCardPreviewData.image),
                    subtitle: Text(ODSCCardPreviewData.subtitle),
                    thumbnail: ODSCCardPreviewData.thumbnail,
                    text: Text(ODSCCardPreviewData.supportingText)) {
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
