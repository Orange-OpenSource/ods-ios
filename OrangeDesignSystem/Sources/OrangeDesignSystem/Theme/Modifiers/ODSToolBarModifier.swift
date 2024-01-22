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

extension View {
    public func toolBarColors(for theme: ODSTheme) -> some View {
        toolBarColors(
            titleColor: theme.componentColors.navigationBarTitle,
            tintColor: theme.componentColors.navigationBarForeground,
            backgroundColor: theme.componentColors.navigationBarBackground)
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
