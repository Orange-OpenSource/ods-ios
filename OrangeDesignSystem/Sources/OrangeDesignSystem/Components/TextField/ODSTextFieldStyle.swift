//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

///
/// <a href="https://system.design.orange.com/0c1af118d/p/47d389-text-fields/b/461794" target="_blank">ODS Text Field</a>.
///
/// The text field component comprises the text field itself, text selection and the edit menu. Some elements are styled and some are native.
///

extension View {
    /// Sets the ods style on __TextField__ and __TextEditor__
    public func odsTextFieldStyle() -> some View {
        modifier(ODSTextFieldStyle())
    }
}

// MARK: - Internal font modifier

///
/// Private modifier to get the theme in environment.
///

private struct ODSTextFieldStyle: ViewModifier {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content
            .accentColor(theme.componentColors.accent)
            .padding(.all, ODSSpacing.s)
            .odsFont(.bodyLRegular)
            .background(Color(.tertiarySystemFill), in: RoundedRectangle(cornerRadius: 8.0))
    }
}
