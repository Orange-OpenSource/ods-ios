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
    func odsFunctionalButtonStyle(style: ODSFunctionalButton.Style, fullWidth: Bool = false) -> some View {
        buttonStyle(ODSFunctionalButtonStyleV2(style: style, fullWidth: fullWidth))
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
            .odsFont(.bodyLBold)
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
