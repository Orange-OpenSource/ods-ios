//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
