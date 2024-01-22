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

import Foundation
import SwiftUI

extension View {

    /// Sets, for text in view, the font provided by theme asociated to the __ODSFontStyle__.
    ///
    /// - Parameters:
    ///     - odsStyle: The default ods font style to use in view.
    ///     - theme: The theme where the style is defined.
    ///
    /// - Returns: A view with the default font set to the value you supply.
    ///
    /// @see font(_ font: Font?) -> some View
    fileprivate func odsFont(_ odsStyle: ODSFontStyle, from theme: ODSTheme) -> some View {
        return font(theme.font(odsStyle))
    }

    /// Sets the font for text in this view defined by the theme in environment for the __ODSFontStyle__.
    ///
    /// - Parameter odsStyle: The default ods font style to use in this view.
    ///
    /// - Returns: A view with the default font set to the value you supply.
    ///
    /// @see font(_ font: Font?) -> some View
    public func odsFont(_ odsStyle: ODSFontStyle) -> some View {
        modifier(FontModifier(fontStyle: odsStyle))
    }
}

// MARK: - Internal font modifier

///
/// Private modifier to get the theme in environment.
///
private struct FontModifier: ViewModifier {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme
    private let fontStyle: ODSFontStyle

    // =================
    // MARK: Initializer
    // =================

    init(fontStyle: ODSFontStyle) {
        self.fontStyle = fontStyle
    }

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content.odsFont(fontStyle, from: theme)
    }
}
