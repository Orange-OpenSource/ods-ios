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
import OrangeDesignSystem

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
    public init(colorSchemes: [ColorScheme] = ColorScheme.allCases,
                @ViewBuilder content: @escaping () -> Content){
        self.colorSchemes = colorSchemes
        self.content = content
    }
    
    public var body: some View {
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

