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

import Flow
import SwiftUI

/// swiftlint:disable line_length
///
/// Banners should be displayed at the top of the screen, below a top app bar.
/// They’re persistent and nonmodal, allowing the user to either ignore them or interact with them at any time. Only one banner should be shown at a time.
///
/// ![Banner light](banner-light.png)
/// ![Banner dark](banner-dark.png)
///
/// ### Buttons in Banner
///
/// A banner can propose up to 2 buttons.
///
///     ODSBanner(text: "One to two lines is preferable on mobile and tablet.") {
///        Button("Button 1") {
///            // your action here
///        }
///     } secondButton: {
///        Button("Button 2") {
///          // your action here
///        }
///     }
///
/// ### Image in Banner
///
/// Images in banner can be laoaded from ressources or form url.
///
///     let placeholder = Image("placeholder", bundle: Bundle.ods)
///     let url = URL(string: "https://images.unsplash.com/photo-1615735487485-e52b9af610c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80")
///
///     ODSBanner(text: "One to two lines is preferable on mobile and tablet.", imageSource: .asyncImage(url, placeholder))
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
    /// Remarks: The default lowest emphasis is automatically applied on buttons.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the banner.
    ///   - imageSource: Image displayed before the text in a circle area. If `nil`, no image will be displayed.
    ///   - firstButton: First (leading) button (text only) added under the text.
    ///   - secondButton: Second (trailing) button (text only) added under the text.
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
    /// Remarks: The default lowest emphasis is automatically applied on buttons.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the banner.
    ///   - imageSource: Image displayed before the text in a circle area. If `nil`, no image will be displayed.
    ///   - button: Button with text (only) added under the text.
    ///
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
                        .odsFont(.bodyS)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, ODSSpacing.m)
                .padding(.bottom, firstButton == nil ? ODSSpacing.m : ODSSpacing.none)
                .padding(.horizontal, ODSSpacing.m)

                buttons()
            }

            Divider()
        }
    }

    // =============
    // MARK: Helpers
    // =============

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
                }
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
                              imageSource: .image(Image("placeholder", bundle: Bundle.ods)))
                        .border(.gray)

                    ODSBanner(Text("A short desciption to see text"),
                              imageSource: .image(Image("placeholder", bundle: Bundle.ods))) {
                        Button("Text") {
                            // Do Something here
                        }
                    }
                    .border(.gray)

                    ODSBanner(Text("A short desciption to see text"),
                              imageSource: .image(Image("placeholder", bundle: Bundle.ods))) {
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
