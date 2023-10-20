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

extension View {
    func odsFunctionalButtonStyle(style: ODSFunctionalButton.Style, fullWidth: Bool = false) -> some View {
        self.buttonStyle(ODSFunctionalButtonStyleV2(style: style, fullWidth: fullWidth))
    }
}

private struct ODSFunctionalButtonStyleV2: ButtonStyle {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.isEnabled) var isEnabled
    @Environment(\.theme) var theme
    private let style: ODSFunctionalButton.Style
    private let fullWidth: Bool

    // =================
    // MARK: Initializer
    // =================

    fileprivate init(style: ODSFunctionalButton.Style, fullWidth: Bool) {
        self.style = style
        self.fullWidth = fullWidth
    }

    @ViewBuilder
    fileprivate func makeBody(configuration: Self.Configuration) -> some View {
        ODSButtonStyleLabel(configuration: configuration,
                            foregroundColor: foregroundColor,
                            backgroundColor: backgroundColor,
                            borderColor: borderColor,
                            fullWidth: fullWidth)
        .odsFont(.bodyBold)
    }

    // ======================
    // MARK: Private helpers
    // ======================

    private var foregroundColor: Color {
        if isEnabled {
            return Color(UIColor.systemBackground)
        } else {
            return Color(UIColor.tertiaryLabel)
        }
    }

    private var backgroundColor: Color {
        if isEnabled {
            switch style {
            case .positive:
                return theme.componentColors.functionalPositive
            case .negative:
                return theme.componentColors.functionalNegative
            }
        } else {
            return Color(UIColor.quaternarySystemFill)
        }
    }

    private var borderColor: Color {
        return .clear
    }
}
