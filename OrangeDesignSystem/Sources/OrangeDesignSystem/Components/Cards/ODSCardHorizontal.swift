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
/// This is a full width card displayed with an image on the left or on the right.
/// This card is composed of two parts:
/// - Media: (today an image)
/// - Content: with a title, an optional subtitle, an optional text and optional buttons (zero up to two)
///

public struct ODSCardHorizontal: View {
    public enum ImagePosition {
        case trailing
        case leading
    }

    private let title: Text
    private let subtitle: Text?
    private let text: Text?
    private let imageSource: ODSImage.Source
    private let imagePosition: ImagePosition
    private let dividerEnabled: Bool
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
    ///  - imagePosition: The side where image is placed.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - text: Optional text description to be displayed in the card. The text displaying is limited to two lines (truncated tail).
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        imagePosition: ImagePosition = .leading,
        subtitle: Text? = nil,
        text: Text? = nil)
    {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.imagePosition = imagePosition
        self.text = text
        dividerEnabled = false
        firstButton = nil
        secondButton = nil
    }

    /// Initialization with one button.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - imagePosition: Side where image is placed.
    ///  - subtitle: Optional subtitle displayed into the card.
    ///  - text: Optional text description displayed into the card. The text
    ///  displaying is limited to two lines (truncated tail).
    ///  - button:  Optional first (leading) button.
    ///  - dividerEnabled: Optional divider added at the top of the buttons area.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        imagePosition: ImagePosition = .leading,
        subtitle: Text? = nil,
        text: Text? = nil,
        dividerEnabled: Bool = true,
        @ViewBuilder button: @escaping () -> Button<Text>)
    {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.imagePosition = imagePosition
        self.text = text

        self.dividerEnabled = dividerEnabled
        firstButton = button
        secondButton = nil
    }

    /// Initialization with two buttons.
    ///
    /// - Parameters:
    ///  - title: Title displayed into the card.
    ///  - imageSource: Image from source [ODSImage.Source] displayed into the card.
    ///  - imagePosition: Side where image is placed.
    ///  - subtitle: Optional subtitle displayed into the card.
    ///  - text: Optional text description displayed into the card. The text
    ///  displaying is limited to two lines (truncated tail).
    ///  - firstButton: Optional first (leading) button.
    ///  - secondButton: Optional second (trailing) button.
    ///  - dividerEnabled: Optional divider added at the top of the buttons area.
    ///
    public init(
        title: Text,
        imageSource: ODSImage.Source,
        imagePosition: ImagePosition = .leading,
        subtitle: Text? = nil,
        text: Text? = nil,
        dividerEnabled: Bool = true,
        @ViewBuilder firstButton: @escaping () -> Button<Text>,
        @ViewBuilder secondButton: @escaping () -> Button<Text>)
    {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.imagePosition = imagePosition
        self.text = text

        self.dividerEnabled = dividerEnabled
        self.firstButton = firstButton
        self.secondButton = secondButton
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {

        VStack(alignment: .leading, spacing: ODSSpacing.none) {
            HStack(alignment: .center, spacing: ODSSpacing.none) {
                if case .leading = imagePosition {
                    image
                }

                VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                    title
                        .odsFont(.bodyLBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    subtitle?
                        .frame(maxWidth: .infinity, alignment: .leading)

                    text?
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .accessibilityElement(children: .combine)
                .foregroundColor(.primary)
                .padding(.all, ODSSpacing.m)

                if case .trailing = imagePosition {
                    image
                }
            }
            .frame(minHeight: 128)

            buttons()
        }
        .background(ODSInternalColor.cardBackground.color)
        .cornerRadius(10)
        .shadow(radius: ODSSpacing.xs)
        .padding(.all, ODSSpacing.s)
    }

    // =====================
    // MARK: Private Helpers
    // =====================

    private var image: some View {
        ODSImage(source: imageSource)
            .frame(width: 128)
            .clipped()
            .accessibilityRemoveTraits(.isImage)
            .accessibilityHidden(true)
    }

    @ViewBuilder
    private func buttons() -> some View {
        if let firstButton = firstButton {
            if dividerEnabled {
                Divider()
            }
            if #available(iOS 16.0, *) {
                HFlow(alignment: .top, spacing: ODSSpacing.none) {
                    firstButton().odsEmphasisButtonStyle(emphasis: .lowest)
                    secondButton?().odsEmphasisButtonStyle(emphasis: .lowest)
                }
            } else {
                HStack(alignment: .center, spacing: ODSSpacing.none) {
                    firstButton().odsEmphasisButtonStyle(emphasis: .lowest)
                    secondButton?().odsEmphasisButtonStyle(emphasis: .lowest)
                }
            }
        }
    }
}

#if DEBUG
struct ODSCardHorizontal_Previews: PreviewProvider {

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
                ODSCardHorizontal(
                    title: Text(ODSCCardPreviewData.title),
                    imageSource: .image(ODSCCardPreviewData.image),
                    imagePosition: .leading,
                    subtitle: Text(ODSCCardPreviewData.subtitle),
                    text: Text(ODSCCardPreviewData.supportingText),
                    dividerEnabled: true)
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
