//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

@main
struct OrangeDesignSystemApp: App {
    @StateObject var themeProvider = ThemeProvider()

    var body: some Scene {
        WindowGroup {
            ODSThemeableView(theme: themeProvider.currentTheme) {
                MainTabView().environmentObject(themeProvider)
            }
        }
    }
}
