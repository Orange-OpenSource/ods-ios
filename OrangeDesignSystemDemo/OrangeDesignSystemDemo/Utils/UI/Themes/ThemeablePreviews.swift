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

import OrangeDesignSystem
import SwiftUI

struct ThemeablePreviews<Content>: View where Content: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let content: () -> Content
    private let colorSchemes: [ColorScheme]

    // ==================
    // MARK: Initializers
    // ==================

    /// Creates an instance with the theme find in ThemeProvider.
    ///
    /// - Parameters:
    ///   - colorSchemes: All cases must be provided for previews
    ///   - content: A view builder that creates the content of this stack.
    ///
    init(colorSchemes: [ColorScheme] = ColorScheme.allCases,
         @ViewBuilder content: @escaping () -> Content)
    {
        self.colorSchemes = colorSchemes
        self.content = content
    }

    var body: some View {
        if !colorSchemes.isEmpty {
            ForEach(colorSchemes, id: \.self) {
                themeableView().preferredColorScheme($0)
            }
        } else {
            themeableView()
        }
    }

    func themeableView() -> some View {
        ODSThemeableView(theme: ThemeProvider().currentTheme) {
            content()
        }
    }
}
