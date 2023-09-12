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

extension View {
    public func toolBarColors(for theme: ODSTheme) -> some View {
        toolBarColors(
            titleColor: theme.componentColors.navigationBarTitle,
            tintColor: theme.componentColors.navigationBarForeground,
            backgroundColor: theme.componentColors.navigationBarBackground
        )
    }

    public func toolBarColors(titleColor: Color, tintColor: Color, backgroundColor: Color) -> some View {
        modifier(
            ToolBarColors(titleColor: UIColor(titleColor),
                          tintColor: UIColor(tintColor),
                          backgroundColor: UIColor(backgroundColor))
        )
    }
}

struct ToolBarColors: ViewModifier {

    init(titleColor: UIColor, tintColor: UIColor, backgroundColor: UIColor = .systemBackground) {

        let coloredAppearance = UIToolbarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.shadowColor = .separator

        let button = UIBarButtonItemAppearance(style: .plain)
        button.normal.titleTextAttributes = [.foregroundColor: tintColor]
        coloredAppearance.buttonAppearance = button

        let done = UIBarButtonItemAppearance(style: .done)
        done.normal.titleTextAttributes = [.foregroundColor: tintColor]
        coloredAppearance.doneButtonAppearance = done

        UIToolbar.appearance().standardAppearance = coloredAppearance
        UIToolbar.appearance().scrollEdgeAppearance = coloredAppearance
        UIToolbar.appearance().compactAppearance = coloredAppearance
        UIToolbar.appearance().compactScrollEdgeAppearance = coloredAppearance

        UIToolbar.appearance().tintColor = tintColor
    }

    func body(content: Content) -> some View {
        content
    }
}
