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
/// This is a full width card displayed with a title and a thumbnail on top as first element.
/// This card is composed of three parts:
/// - Header: with a title, an optional subtitle and an optional thmubnail
/// - Media: (today an image)
/// - Content: with an optional text and optional buttons (zero up to two)
///
public struct ODSCardVerticalHeaderFirst: View {

    private let title: Text
    private let subtitle: Text?
    private let thumbnailSource: ODSImage.Source?
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
    ///  - title: Title displayed into the header of the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card
    ///  - subtitle: Optional subtitle displayed into the header of the card.
    ///  - thumbnailSource: Optional thumbnail (avatar, logo or icon) from source [ODSImage.Source] next to the title.
    ///  - text: Optional text description displayed into the card.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text?,
        thumbnailSource: ODSImage.Source?,
        text: Text? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.thumbnailSource = thumbnailSource
        self.imageSource = imageSource
        self.text = text
        firstButton = nil
        secondButton = nil
    }

    /// Initialization with one button.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the header of the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - subtitle: Optional subtitle displayed into the header of the card.
    ///  - thumbnailSource: Optional thumbnail (avatar, logo or icon) from source [ODSImage.Source] next to the title.
    ///  - text: Optional text description displayed into the card.
    ///  - button: The optional button.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text?,
        thumbnailSource: ODSImage.Source?,
        text: Text? = nil,
        @ViewBuilder button: @escaping () -> Button<Text>)
    {
        self.title = title
        self.subtitle = subtitle
        self.thumbnailSource = thumbnailSource
        self.imageSource = imageSource
        self.text = text
        firstButton = button
        secondButton = nil
    }

    /// Initialization with two buttons.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the header of the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - subtitle: Optional subtitle displayed into the header of the card.
    ///  - thumbnailSource: Optional thumbnail (avatar, logo or icon) from source [ODSImage.Source] next to the title.
    ///  - text: Optional text description displayed into the card.
    ///  - firstButton: The optional first (leading) button.
    ///  - secondButton: The optional second (trailing) button.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        subtitle: Text? = nil,
        thumbnailSource: ODSImage.Source? = nil,
        text: Text? = nil,
        dividerEnabled: Bool = true,
        @ViewBuilder firstButton: @escaping () -> Button<Text>,
        @ViewBuilder secondButton: @escaping () -> Button<Text>)
    {
        self.title = title
        self.subtitle = subtitle
        self.thumbnailSource = thumbnailSource
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
                if let thumbnailSource = thumbnailSource {
                    ODSImage(source: thumbnailSource)
                        .frame(width: 44.0, height: 44.0, alignment: .center)
                        .clipShape(Circle())
                        .accessibilityHidden(true)
                }

                VStack(alignment: .leading, spacing: ODSSpacing.none) {
                    title
                        .odsFont(.bodyLBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    subtitle?
                        .odsFont(.bodyLRegular)
                }
                .accessibilityElement(children: .combine)
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.primary)
            .padding(.vertical, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
            .layoutPriority(100)

            ODSImage(source: imageSource)
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: 192, alignment: .center)
                .clipped()
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                text?
                    .odsFont(.bodyLRegular)
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

        var body: some View {
            ScrollView {
                ODSCardVerticalHeaderFirst(
                    title: Text(ODSCCardPreviewData.title),
                    imageSource: .image(ODSCCardPreviewData.image),
                    subtitle: Text(ODSCCardPreviewData.subtitle),
                    thumbnailSource: .image(ODSCCardPreviewData.thumbnail),
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
