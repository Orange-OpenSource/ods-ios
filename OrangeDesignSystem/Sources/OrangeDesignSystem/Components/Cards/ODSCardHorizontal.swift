//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

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
    ///  - title: The title to be displayed in the card.
    ///  - imageSource: The image to be displayed in the card.
    ///  - imagePosition: The side where image is placed.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - text: Optional text description to be displayed in the card. The text
    ///  displaying is limited to two lines (truncated tail).
    ///  - button: The optional first (leading) button.
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
    ///  - title: The title to be displayed in the card.
    ///  - imageSource: The image to be displayed in the card.
    ///  - imagePosition: The side where image is placed.
    ///  - subtitle: Optional subtitle to be displayed in the card.
    ///  - text: Optional text description to be displayed in the card. The text
    ///  displaying is limited to two lines (truncated tail).
    ///  - firstButton: The optional first (leading) button.
    ///  - secondButton: The optional second (trailing) button.
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

        VStack(spacing: ODSSpacing.none) {
            HStack(alignment: .center, spacing: ODSSpacing.none) {
                if case .leading = imagePosition {
                    image
                }

                VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                    title
                        .odsFont(.bodyBold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    subtitle?
                        .frame(maxWidth: .infinity, alignment: .leading)

                    text?
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
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
            .accessibilityHidden(true)
            .frame(width: 128)
            .clipped()
    }

    @ViewBuilder
    private func buttons() -> some View {
        if let firstButton = firstButton {
            if dividerEnabled {
                Divider()
            }

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
