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
                @ViewBuilder secondButton: @escaping () -> Button<Text>) {
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
        self.firstButton = button
        self.secondButton = nil
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
        self.firstButton = nil
        self.secondButton = nil
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
                    .padding(.all, ODSSpacing.m) // Still the style does not contain the padding
                    .modifier(ODSButtonStyleModifier(emphasis: .lowest))
                secondButton?()
                    .padding(.all, ODSSpacing.m) // Still the style does not contain the padding
                    .modifier(ODSButtonStyleModifier(emphasis: .lowest))
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
