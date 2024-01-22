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
