//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

extension View {
    public func navigationBarColors(for theme: ODSTheme) -> some View {
        navigationBarColors(
            titleColor: theme.componentColors.navigationBarTitle,
            tintColor: theme.componentColors.navigationBarForeground,
            backgroundColor: theme.componentColors.navigationBarBackground)
    }

    public func navigationBarColors(titleColor: Color, tintColor: Color, backgroundColor: Color) -> some View {
        modifier(
            NavigationBarColors(titleColor: UIColor(titleColor),
                                tintColor: UIColor(tintColor),
                                backgroundColor: UIColor(backgroundColor))
        )
    }
}

struct NavigationBarColors: ViewModifier {

    init(titleColor: UIColor, tintColor: UIColor, backgroundColor: UIColor = .systemBackground) {

        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithDefaultBackground()
        coloredAppearance.backgroundColor = backgroundColor

        coloredAppearance.shadowColor = .separator
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        coloredAppearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: tintColor]

        if #available(iOS 16.0, *) {
            let image = UIImage(systemName: "chevron.backward")?.withTintColor(tintColor, renderingMode: .alwaysOriginal) // fix indicator color
            coloredAppearance.setBackIndicatorImage(image, transitionMaskImage: image)
        }

        let button = UIBarButtonItemAppearance(style: .plain)
        button.normal.titleTextAttributes = [.foregroundColor: tintColor]
        coloredAppearance.buttonAppearance = button

        let done = UIBarButtonItemAppearance(style: .done)
        done.normal.titleTextAttributes = [.foregroundColor: tintColor]
        coloredAppearance.doneButtonAppearance = done

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = coloredAppearance

        UINavigationBar.appearance().tintColor = tintColor
    }

    func body(content: Content) -> some View {
        content
    }
}
