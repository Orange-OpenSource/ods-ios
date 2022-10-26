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

/// Define functional buttons (positive or negative)
public struct ODSFunctionalButton: View {
    @Environment(\.theme) var theme
    
    public enum Style: String, CaseIterable {
        case negative
        case positive
    }

    let text: LocalizedStringKey
    let image: Image?
    let style: ODSFunctionalButton.Style
    let variableWidth: Bool
    let action: () -> Void

    /// Initialize the button.
    ///
    /// - Parameters:
    ///   - text: Text displayed in the button.
    ///   - image: Painter of the icon. If `nil`, no icon will be displayed.
    ///   - style: Controls the style of the button. To get a green/red buttons, you can use  `ODSFunctionalButton.Style.positive` or `ODSFunctionalButton.Style.negative`.
    ///   - variableWidth: Defines the size of the button layout. Set to `true`, the size of the button is limited to the size of the text added by a padding round it. Set to `false` means button takes all available space horizontally.
    ///   - action: Will be called when the user clicks the button.
    ///
    public init(text: LocalizedStringKey,
                image: Image? = nil,
                style: ODSFunctionalButton.Style,
                variableWidth: Bool = true,
                action: @escaping () -> Void)
    {
        self.text = text
        self.image = image
        self.style = style
        self.variableWidth = variableWidth
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            ODSButtonContent(text: text, image: image, variableWidth: variableWidth)
        }
        .buttonStyle(ODSShapedButtonStyle(shapeType: .filled, foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }

    var foregroundColor: Color {
        Color(UIColor.systemBackground)
    }

    var backgroundColor: Color {
        switch style {
        case .negative:
            return theme.componentColors.functionalNegative
        case .positive:
            return theme.componentColors.functionalPositive
        }
    }
}

#if DEBUG
struct ODSFunctionalButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: ODSSpacing.xl) {
            VStack {
                Text("Without image")
                ODSFunctionalButton(text: "Enabled", style: .negative) {}
                ODSFunctionalButton(text: "Disabled", style: .negative) {}.disabled(true)
            }

            VStack {
                Text("Without image")
                ODSFunctionalButton(text: "Enabled", image: Image(systemName: "pencil.tip"), style: ODSFunctionalButton.Style.negative) {}
                ODSFunctionalButton(text: "Disabled", image: Image(systemName: "pencil.tip"), style: ODSFunctionalButton.Style.negative) {}.disabled(true)
            }
        }
    }
}
#endif
