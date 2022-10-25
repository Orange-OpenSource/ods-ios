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

import Foundation
import SwiftUI

extension View {
    /// Sets the font for text in this view defined by the __ODSFontStyle__
    /// provided by theme.
    ///
    /// - Parameters
    ///     - odsStyle: The default ods font style to use in this view.
    ///     - thme: The theme where the style is defined.
    ///
    /// - Returns: A view with the default font set to the value you supply.
    ///
    /// @see font(_ font: Font?) -> some View
    public func odsFont(_ odsStyle: ODSFontStyle, from theme: ODSTheme) -> some View {
        return font(theme.font(odsStyle))
    }

    /// Sets the font for text in this view defined by the __ODSFontStyle__
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

struct FontModifier: ViewModifier {
    @Environment(\.theme) var theme
    let fontStyle: ODSFontStyle

    init(fontStyle: ODSFontStyle) {
        self.fontStyle = fontStyle
    }

    func body(content: Content) -> some View {
        content.odsFont(self.fontStyle, from: theme)
    }
}
