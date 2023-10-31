//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
