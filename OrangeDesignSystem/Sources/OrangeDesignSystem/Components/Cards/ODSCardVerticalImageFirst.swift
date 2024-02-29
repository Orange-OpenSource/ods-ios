//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import SwiftUI
import Flow

///
/// <a href="https://system.design.orange.com/0c1af118d/p/66bac5-cards/b/1591fb" target="_blank">ODS Card</a>.
///
/// This is a full width card displayed with an image as first element.
/// This card is composed of two parts:
/// - Media: (today an image)
/// - Content: with a title, an optional subtitle, an optional supporting text and optional buttons (zero up to two)
///
public struct ODSCardVerticalImageFirst: View {

    private let title: Text
    private let subtitle: Text?
    private let imageSource: ODSImage.Source
    private let text: Text?
    private let firstButton: (() -> Button<Text>)?
    private let secondButton: (() -> Button<Text>)?

    /// Initialization without button.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - subtitle: Optional subtitle displayed into the card.
    ///  - text: Optional text description displayed into the card.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        text: Text? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.text = text
        firstButton = nil
        secondButton = nil
    }

    /// Initialization with one button.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - subtitle: Optional subtitle displayed into the card.
    ///  - text: Optional text description displayed into the card.
    ///  - button: The button with text only (lowest emphasis).
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        text: Text? = nil,
        @ViewBuilder button: @escaping () -> Button<Text>)
    {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.text = text
        firstButton = button
        secondButton = nil
    }

    /// Initialization with two buttons.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - subtitle: Optional subtitle displayed into the card.
    ///  - text: Optional text description displayed into the card.
    ///  - firstButton: The first (leading) button text.
    ///  - secondButton: The second (trailing) button text.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        text: Text? = nil,
        @ViewBuilder firstButton: @escaping () -> Button<Text>,
        @ViewBuilder secondButton: @escaping () -> Button<Text>)
    {
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
                    .frame(maxHeight: 192, alignment: .center)
                    .clipped()
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                    title
                        .odsFont(.bodyLBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    subtitle?
                        .frame(maxWidth: .infinity, alignment: .leading)

                    text?
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .accessibilityElement(children: .combine)
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
            if #available(iOS 16.0, *) {
                HFlow(alignment: .top, spacing: ODSSpacing.none) {
                    firstButton().odsEmphasisButtonStyle(emphasis: .lowest)
                    secondButton?().odsEmphasisButtonStyle(emphasis: .lowest)
                }
            } else {
                HStack(alignment: .center, spacing: ODSSpacing.none) {
                    firstButton().odsEmphasisButtonStyle(emphasis: .lowest)
                    secondButton?().odsEmphasisButtonStyle(emphasis: .lowest)
                    Spacer()
                }
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
                    text: Text(ODSCCardPreviewData.supportingText))
                {
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
