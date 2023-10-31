//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

extension View {
    public func tabBarColors(for theme: ODSTheme) -> some View {
        tabBarStyle(backgroundColor: theme.componentColors.tabBarBackground,
                    itemColor: theme.componentColors.tabBarItem,
                    selectedItemColor: theme.componentColors.tabBarSelectedItem,
                    badgeColor: .red)
    }

    public func tabBarStyle(
        backgroundColor: Color? = nil,
        itemColor: Color? = nil,
        selectedItemColor: Color? = nil,
        badgeColor: Color? = nil) -> some View
    {
        onAppear {
            let itemAppearance = UITabBarItemAppearance()
            if let uiItemColor = itemColor?.uiColor {
                itemAppearance.normal.iconColor = uiItemColor
                itemAppearance.normal.titleTextAttributes = [
                    .foregroundColor: uiItemColor,
                ]
            }
            if let uiSelectedItemColor = selectedItemColor?.uiColor {
                itemAppearance.selected.iconColor = uiSelectedItemColor
                itemAppearance.selected.titleTextAttributes = [
                    .foregroundColor: uiSelectedItemColor,
                ]
            }
            if let uiBadgeColor = badgeColor?.uiColor {
                itemAppearance.normal.badgeBackgroundColor = uiBadgeColor
                itemAppearance.selected.badgeBackgroundColor = uiBadgeColor
            }

            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = backgroundColor?.uiColor

            appearance.stackedLayoutAppearance = itemAppearance
            appearance.inlineLayoutAppearance = itemAppearance
            appearance.compactInlineLayoutAppearance = itemAppearance

            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
