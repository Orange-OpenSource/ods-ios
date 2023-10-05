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
        text: Text? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.imagePosition = imagePosition
        self.text = text
        self.dividerEnabled = false
        self.firstButton = nil
        self.secondButton = nil
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
        @ViewBuilder button: @escaping () -> Button<Text>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageSource = imageSource
        self.imagePosition = imagePosition
        self.text = text

        self.dividerEnabled = dividerEnabled
        self.firstButton = button
        self.secondButton = nil
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
        @ViewBuilder secondButton: @escaping () -> Button<Text>
    ) {
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
        @State var disableButton1 = false

        var body: some View {
            ScrollView {
                ODSCardHorizontal(
                    title: Text(ODSCCardPreviewData.title),
                    imageSource: .image(ODSCCardPreviewData.image),
                    imagePosition: .leading,
                    subtitle: Text(ODSCCardPreviewData.subtitle),
                    text: Text(ODSCCardPreviewData.supportingText),
                    dividerEnabled: true) {
                        Button("Button 1") {
                            showTextInToast = "Button 1 Clicked"
                        }
                    } secondButton: {
                        Button("\(disableButton1 ? "Enable" : "Disable") Button 1") {
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
