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

/// Defines functional buttons (positive or negative)
public struct ODSFunctionalButton: View {

    public enum Style: String, CaseIterable {
        case negative
        case positive
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    private let text: Text
    private let image: Image?
    private let style: ODSFunctionalButton.Style
    private let fullWidth: Bool
    private let action: () -> Void

    // =================
    // MARK: Initializer
    // =================

    /// Initialize the button.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - style: Controls the style of the button. To get a green/red buttons, you can use  `ODSFunctionalButton.Style.positive` or `ODSFunctionalButton.Style.negative`.
    ///   - fullWidth: Defines the size of the button layout. Set to `true` means button takes all available space horizontally. Set to `false`, the size of the button is limited to the size of the text added by a padding round it.
    ///   - action: Will be called when the user clicks the button.
    ///
    public init(
        text: Text,
        image: Image? = nil,
        style: ODSFunctionalButton.Style,
        fullWidth: Bool = false,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.image = image
        self.style = style
        self.fullWidth = fullWidth
        self.action = action
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Button {
            action()
        } label: {
            ODSButtonContent(text, image: image)
        }
        .odsFunctionalButtonStyle(style: style, fullWidth: fullWidth)
    }
}

#if DEBUG
struct ODSFunctionalButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: ODSSpacing.xl) {
            VStack {
                Text("Without image")
                ODSFunctionalButton(text: Text("Enabled"), style: .negative) {}
                ODSFunctionalButton(text: Text("Disabled"), style: .negative) {}.disabled(true)
            }

            VStack {
                Text("Without image")
                ODSFunctionalButton(text: Text("Enabled"), image: Image(systemName: "pencil.tip"), style: ODSFunctionalButton.Style.negative) {}
                ODSFunctionalButton(text: Text("Disabled"), image: Image(systemName: "pencil.tip"), style: ODSFunctionalButton.Style.negative) {}.disabled(true)
            }
        }
    }
}
#endif
