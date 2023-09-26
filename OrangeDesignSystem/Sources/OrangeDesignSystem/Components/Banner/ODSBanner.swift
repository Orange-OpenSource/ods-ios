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

public typealias ODSBannerButton = (text: String, onClick: () -> Void)

/// A banner displays an important message which requires an
/// action to be dismissed.
///
public struct ODSBanner: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let text: LocalizedStringKey
    private let image: Image?
    private let firstButton: ODSBannerButton?
    private let secondButton: ODSBannerButton?

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the simpliest banner with 0 or one button.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - button: The button added under text.
    ///
    /// - Remarks: The default low emphasis is automatically applied on buttons.

    public init(
        text: LocalizedStringKey,
        image: Image? = nil,
        button: ODSBannerButton? = nil
    ) {
        self.text = text
        self.image = image
        self.firstButton = button
        self.secondButton = nil
    }

    /// Initialize the simpliest banner with two buttons added under text.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - firstButton: The first button.
    ///   - secondButton: The second button.
    ///
    /// - Remarks: The default low emphasis is automatically applied on buttons.

    public init(
        text: LocalizedStringKey,
        image: Image? = nil,
        firstButton: ODSBannerButton,
        secondButton: ODSBannerButton
    ) {
        self.text = text
        self.image = image
        self.firstButton = firstButton
        self.secondButton = secondButton
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(spacing: ODSSpacing.none) {
            VStack(alignment: .trailing, spacing: ODSSpacing.none) {
                HStack(spacing: ODSSpacing.s) {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40.0, height: 40.0, alignment: .center)
                        .clipShape(Circle())
                        .accessibilityHidden(true)

                    Text(text)
                        .odsFont(.subhead)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, ODSSpacing.m)
                .padding(.bottom, firstButton == nil ? ODSSpacing.m : ODSSpacing.none)

                bottomButtons()
            }

            Divider()
        }
        .padding(.horizontal, ODSSpacing.m)
    }

    // =============
    // MARK: Helpers
    // =============

    @ViewBuilder
    private func bottomButtons() -> some View {
        if let firstButton = firstButton {
            HStack(spacing: ODSSpacing.none) {
                ODSButton(text: LocalizedStringKey(firstButton.text), emphasis: .low) {
                    firstButton.onClick()
                }

                if let secondButton = secondButton {
                    ODSButton(text: LocalizedStringKey(secondButton.text), emphasis: .low) {
                        secondButton.onClick()
                    }
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
                    ODSBanner(text: "A short desciption to see text",
                              image: Image("ods_empty", bundle: Bundle.ods))
                    .border(.gray)

                    ODSBanner(text: "A short desciption to see text",
                              image: Image("ods_empty", bundle: Bundle.ods),
                              button: ODSBannerButton("Button", {})
                    )

                    .border(.gray)

                    ODSBanner(text: "A short desciption to see text",
                              image: Image("ods_empty", bundle: Bundle.ods),
                              firstButton: ODSBannerButton(text: "Button", onClick: {}),
                              secondButton: ODSBannerButton(text: "Button", onClick: {})
                    )
                    .border(.gray)
                }
            }
            .preferredColorScheme($0)
        }
    }
}
#endif
