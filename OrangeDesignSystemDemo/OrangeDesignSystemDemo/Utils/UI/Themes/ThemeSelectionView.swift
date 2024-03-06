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

import InnovationCupTheme
import OrangeDesignSystem
import OrangeTheme
import SwiftUI

/// Theme provider that proposes all supported themes for the demo application.
/// It also stores the current theme, selected by user.
final class ThemeProvider: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    var currentTheme: ODSTheme {
        didSet {
            if currentTheme != oldValue {
                hotSwitchWarningIndicator.showAlert = true
            }
            UserDefaults.standard.set(currentTheme.name, forKey: "themeName")
        }
    }

    var hotSwitchWarningIndicator: HotSwitchWarningIndicator
    let themes: [ODSTheme]

    // ==================
    // MARK: Initializers
    // ==================

    init() {
        let orangeTheme = OrangeThemeFactory().theme
        let innovationCupTheme = InnovationCupThemeFactory().theme
        let defaultTheme = orangeTheme
        themes = [orangeTheme, innovationCupTheme]

        if let themeName = UserDefaults.standard.value(forKey: "themeName") as? String,
           let theme = themes.first(where: { $0.name == themeName })
        {
            currentTheme = theme
        } else {
            currentTheme = defaultTheme
        }

        hotSwitchWarningIndicator = HotSwitchWarningIndicator()
    }

    /// Returns a decorative image (so as to prevent _Voice Over_ to vocalize it) with the given name.
    /// A bundle can be assigned, otherwise no bundle will be used (i.e. resource in app).
    /// - Parameters:
    ///    - name: The name of the image, which can be suffixed according to the theme
    ///    - inThemeBundle: If `false` no bundle will be used, otherwise will use the theme bundle.
    /// - Returns: The decorative image
    func imageFromResources(name: String, inThemeBundle: Bool = false) -> Image {
        let imageName = currentTheme.name == InnovationCupThemeFactory.themeName ? "\(name) (Innovation Cup)" : name
        if inThemeBundle { // Supposing the themes have the same types of images but some of them are suffixed
            return Image(decorative: imageName, bundle: currentTheme.bundle)
        } else {
            return Image(decorative: imageName)
        }
    }
}

extension View {
    func navigationbarMenuForThemeSelection() -> some View {
        toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ThemeSelectionButton()
            }
        }
    }
}

// ==============================
// MARK: - Theme Selection Button
// ==============================

/// Button is added in navigation bar to allow, the user to change the current theme.
struct ThemeSelectionButton: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @EnvironmentObject private var themeProvider: ThemeProvider

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Menu {
            Picker(selection: $themeProvider.currentTheme, label: EmptyView()) {
                ForEach(themeProvider.themes, id: \.id) { theme in
                    Text(theme.name).tag(theme)
                }
            }
            .pickerStyle(.automatic)
        } label: {
            Image(systemName: "paintpalette")
        }
        .foregroundColor(themeProvider.currentTheme.componentColors.navigationBarForeground)
        .modifier(HotSwhitchIndicatorModifier(hotSwitchWarningIndicator: themeProvider.hotSwitchWarningIndicator))
    }
}

// ===========================
// MARK: - Hot Switch Warning
// ===========================

/// Will be removed when hot switch will be supported
final class HotSwitchWarningIndicator: ObservableObject {
    @Published var showAlert: Bool = false
}

struct HotSwhitchIndicatorModifier: ViewModifier {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var hotSwitchWarningIndicator: HotSwitchWarningIndicator

    // ==================
    // MARK: Initializers
    // ==================

    init(hotSwitchWarningIndicator: HotSwitchWarningIndicator) {
        self.hotSwitchWarningIndicator = hotSwitchWarningIndicator
    }

    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .alert("Warning", isPresented: $hotSwitchWarningIndicator.showAlert) {} message: {
                Text("You need to restart application to see design with new theme").odsFont(.titleM)
            }
    }
}
