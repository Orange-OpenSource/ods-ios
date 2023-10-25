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
    public init(theme: ODSTheme, @ViewBuilder content: @escaping () -> Content){
        self.theme = theme
        self.content = content
        _ = self.navigationBarColors(for: theme)
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
