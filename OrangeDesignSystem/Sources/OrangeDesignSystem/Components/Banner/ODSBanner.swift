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

    public enum OneButtonPosition {
        case trailing
        case bottom
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    private let text: LocalizedStringKey
    private let image: Image?
    private let buttonOptions: ButtonsOptions?

    // ==================
    // MARK: Initializers
    // ==================

    /// Initialize the simpliest banner with no buttons.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    public init(text: LocalizedStringKey, image: Image? = nil) {
        self.text = text
        self.image = image
        self.buttonOptions = nil
    }

    /// Initialize the banner with one button. This button
    /// can be palaced under or next to the text.
    ///
    /// - Parameters:
    ///   - text: Text to be displayed.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - button: The button
    ///   - position: The positiobn of the button
    ///
    /// - Remarks: The default low emphasis is automatically applied on buttons.
    public init(text: LocalizedStringKey,
                image: Image? = nil,
                button: ODSButton,
                position: OneButtonPosition
    ) {
        self.text = text
        self.image = image
        self.buttonOptions = .oneButton(button, position)
    }

    /// Initialize the banner with two buttons palaced under the text.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - leadingButton: The first button.
    ///   - trailingButton: The second button.
    ///
    /// - Remarks: The default low emphasis is automatically applied on buttons.
    ///
    public init(text: LocalizedStringKey,
                image: Image? = nil,
                leadingButton: ODSButton,
                trailingButton: ODSButton
    ) {
        self.text = text
        self.image = image
        self.buttonOptions = .twoButtons(leadingButton, trailingButton)
    }
    
    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(spacing: ODSSpacing.m) {
            HStack(spacing: ODSSpacing.s) {
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40.0, height: 40.0, alignment: .center)
                    .clipShape(Circle())

                Text(text)
                    .odsFont(.subhead)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                nextToTextButton()
            }

            bottomButtons()
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }

    // =============
    // MARK: Helpers
    // =============

    @ViewBuilder
    private func nextToTextButton() -> some View {
        if case let .oneButton(button, position) = buttonOptions,
           position == .trailing {
            button.modifier(ODSButtonStyleModifier(emphasis: .low))
        }
    }

    @ViewBuilder
    private func bottomButtons() -> some View {
        if case let .oneButton(button, position) = buttonOptions,
           position == .bottom {
            HStack {
                Spacer()
                button.modifier(ODSButtonStyleModifier(emphasis: .low))
            }
        } else {
            if case let .twoButtons(leadingButton, tralingButton) = buttonOptions {
                HStack(spacing: ODSSpacing.s) {
                    Spacer()
                    leadingButton.modifier(ODSButtonStyleModifier(emphasis: .low))
                    tralingButton.modifier(ODSButtonStyleModifier(emphasis: .low))
                }
            }
        }
    }

    private enum ButtonsOptions {
        case oneButton(ODSButton, OneButtonPosition)
        case twoButtons(ODSButton, ODSButton)
    }
}

#if DEBUG
struct ODSBanner_Previews: PreviewProvider {

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ODSBanner(text: "Title",
                      image: Image("ods_empty", bundle: Bundle.ods))
                .preferredColorScheme($0)
        }
    }
}
#endif
