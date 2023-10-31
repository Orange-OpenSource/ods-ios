//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

/// A banner displays an important message which requires an
/// action to be dismissed.
///
public struct ODSBanner: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let text: Text
    private let imageSource: ODSImage.Source?
    private let firstButton: (() -> Button<Text>)?
    private let secondButton: (() -> Button<Text>)?

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the banner with two buttons added under the text.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the banner.
    ///   - imageSource: Image displayed before the text in a circle area. If `nil`, no image will be displayed.
    ///   - firstButton: First (leading) button (text only) added under the text.
    ///   - secondButton: Second (trailing) button (text only) added under the text.
    ///
    /// - Remarks: The default lowest emphasis is automatically applied on buttons.

    public init(_ text: Text,
                imageSource: ODSImage.Source? = nil,
                @ViewBuilder firstButton: @escaping () -> Button<Text>,
                @ViewBuilder secondButton: @escaping () -> Button<Text>)
    {
        self.text = text
        self.imageSource = imageSource
        self.firstButton = firstButton
        self.secondButton = secondButton
    }

    /// Initialize the banner with one button.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the banner.
    ///   - imageSource: Image displayed before the text in a circle area. If `nil`, no image will be displayed.
    ///   - button: Button with text (only) added under the text.
    ///
    /// - Remarks: The default lowest emphasis is automatically applied on buttons.

    public init(_ text: Text,
                imageSource: ODSImage.Source? = nil,
                @ViewBuilder button: @escaping () -> Button<Text>)
    {
        self.text = text
        self.imageSource = imageSource
        firstButton = button
        secondButton = nil
    }

    /// Initialize the banner without button.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the banner.
    ///   - imageSource: Image displayed before the text in a circle area. If `nil`, no image will be displayed.
    ///
    public init(_ text: Text, imageSource: ODSImage.Source? = nil) {
        self.text = text
        self.imageSource = imageSource
        firstButton = nil
        secondButton = nil
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(spacing: ODSSpacing.none) {
            VStack(alignment: .trailing, spacing: ODSSpacing.none) {
                HStack(spacing: ODSSpacing.m) {
                    if let imageSource = imageSource {
                        ODSImage(source: imageSource)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40.0, height: 40.0, alignment: .center)
                            .clipShape(Circle())
                            .accessibilityHidden(true)
                    }

                    text
                        .odsFont(.subhead)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, ODSSpacing.m)
                .padding(.bottom, firstButton == nil ? ODSSpacing.m : ODSSpacing.none)
                .padding(.horizontal, ODSSpacing.m)

                bottomButtons()
            }

            Divider()
        }
    }

    // =============
    // MARK: Helpers
    // =============

    @ViewBuilder
    private func bottomButtons() -> some View {
        if let firstButton = firstButton {
            HStack(spacing: ODSSpacing.none) {
                firstButton()
                    .odsEmphasisButtonStyle(emphasis: .lowest)
                secondButton?()
                    .odsEmphasisButtonStyle(emphasis: .lowest)
            }
        }
    }
}

#if DEBUG
struct ODSBanner_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ODSThemeableView(theme: ODSTheme()) {
                VStack {
                    ODSBanner(Text("A short desciption to see text"))
                        .border(.gray)

                    ODSBanner(Text("A short desciption to see text"),
                              imageSource: .image(Image("ods_empty", bundle: Bundle.ods)))
                        .border(.gray)

                    ODSBanner(Text("A short desciption to see text"),
                              imageSource: .image(Image("ods_empty", bundle: Bundle.ods))) {
                        Button("Text") {
                            // Do Something here
                        }
                    }
                    .border(.gray)

                    ODSBanner(Text("A short desciption to see text"),
                              imageSource: .image(Image("ods_empty", bundle: Bundle.ods))) {
                        Button("Button 1") {
                            // Do something
                        }
                    } secondButton: {
                        Button("Button 2") {
                            // Do something
                        }
                    }
                    .border(.gray)
                }
            }
            .preferredColorScheme($0)
        }
    }
}
#endif
