//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
