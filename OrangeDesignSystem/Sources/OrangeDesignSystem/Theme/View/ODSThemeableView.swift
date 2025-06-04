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

/// A view that applies the theme for all subviews.
///
/// The navigation and tab bars appearance are also modified according
/// to styles provided by the theme (background and title colors, fonts,
/// ...)
///
/// The theme is added in the environment in order to be available in subviews.
///
/// The following example shows how to build a `ODSThemeableView` and get
/// the theme from environment in subview:
///
///     struct YourView: View {
///         var body: some View {
///             ODSThemeableView(theme: theme) {
///                 ThemeNameView()
///             }
///         }
///     }
///
///     struct ThemeNameView: View {
///         @Environment(\.theme) private let theme
///
///         var body: some View {
///             Text(theme.name)
///         }
///     }
///

public struct ODSThemeableView<Content>: View where Content: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let theme: ODSTheme
    private let content: () -> Content

    // ==================
    // MARK: Initializers
    // ==================

    /// Creates an instance with the theme to be applied.
    ///
    /// - Parameters:
    ///   - theme: The new theme to be applied.
    ///   - content: A view builder that creates the content of this stack.
    ///
    public init(theme: ODSTheme, @ViewBuilder content: @escaping () -> Content) {
        self.theme = theme
        self.content = content
        _ = navigationBarColors(for: theme)
        print("🚨 WARNING: Orange Design System (ODS) is not maintained anymore.")
        print("🚨 You should move instead to Orange Unified Design System")
        print("🚨 For more details go to https://github.com/Orange-OpenSource/ouds-ios")
    }

    public var body: some View {
        content()
            .accentColor(theme.componentColors.accent)
            .environment(\.theme, theme)
            .navigationBarColors(for: theme)
            .tabBarColors(for: theme)
            .toolBarColors(for: theme)
    }
}
