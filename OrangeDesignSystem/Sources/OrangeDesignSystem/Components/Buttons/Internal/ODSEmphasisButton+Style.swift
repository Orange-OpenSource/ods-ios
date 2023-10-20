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
    func odsEmphasisButtonStyle(emphasis: ODSButton.Emphasis, fullWidth: Bool = false) -> some View {
        self.buttonStyle(ODSEmphasisButtonStyle(emphasis: emphasis, fullWidth: fullWidth))
    }
}

private struct ODSEmphasisButtonStyle: ButtonStyle {

    // =======================
    // MARK: Stored properties
    // =======================

    @Environment(\.isEnabled) var isEnabled
    @Environment(\.theme) var theme
    private let emphasis: ODSButton.Emphasis
    private let fullWidth: Bool

    // =================
    // MARK: Initializer
    // =================

    fileprivate init(emphasis: ODSButton.Emphasis, fullWidth: Bool) {
        self.emphasis = emphasis
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
            switch emphasis {
            case .high:
                return theme.componentColors.highEmphasisText
            case .medium:
                return Color(UIColor.systemBackground)
            case .low:
                return Color(UIColor.label)
            case .lowest:
                return theme.componentColors.accent
            }
        } else {
            return Color(UIColor.tertiaryLabel)
        }
    }

    private var backgroundColor: Color {
        if isEnabled {
            switch emphasis {
            case .high:
                return theme.componentColors.accent
            case .medium:
                return Color(UIColor.label)
            case .low:
                return Color(UIColor.systemBackground)
            case .lowest:
                return Color.clear
            }
        } else {
            switch emphasis {
            case .high, .medium, .low:
                return Color(UIColor.quaternarySystemFill)
            case .lowest:
                return Color.clear
            }
        }
    }

    private var borderColor: Color {
        if isEnabled {
            switch emphasis {
            case .high:
                return .clear
            case .medium:
                return .clear
            case .low:
                return Color(UIColor.label)
            case .lowest:
                return .clear
            }
        } else {
            return .clear
        }
    }
}
