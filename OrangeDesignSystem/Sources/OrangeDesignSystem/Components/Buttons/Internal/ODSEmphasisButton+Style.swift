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

import SwiftUI

extension View {
    func odsEmphasisButtonStyle(emphasis: ODSButton.Emphasis, fullWidth: Bool = false) -> some View {
        buttonStyle(ODSEmphasisButtonStyle(emphasis: emphasis, fullWidth: fullWidth))
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
            .odsFont(.bodyLBold)
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
