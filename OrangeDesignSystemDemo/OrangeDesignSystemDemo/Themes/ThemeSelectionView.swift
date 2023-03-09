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

import OrangeDesignSystem
import InnovationCupTheme
import OrangeTheme
import SwiftUI

///
/// Theme provider that propose all supported themes for the
/// demo application.
/// It also stores the current theme, selected by user.
///
class ThemeProvider: ObservableObject {
        
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
        let defaultTheme = innovationCupTheme
        themes = [orangeTheme, innovationCupTheme]

        if let themeName = UserDefaults.standard.value(forKey: "themeName") as? String,
            let theme = themes.first( where: { $0.name == themeName } ) {
            self.currentTheme = theme
        } else {
            self.currentTheme = defaultTheme
        }
        
        self.hotSwitchWarningIndicator = HotSwitchWarningIndicator()
    }
    
    func imageFromResources(_ name: String) -> Image {
        let isOrangeTheme = currentTheme.name == OrangeThemeFactory.themeName
        let imageName = isOrangeTheme ? name : "\(name)_generic"
        return Image(imageName)
    }
}

extension View {
    func navigationbarMenuForThemeSelection() -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                ThemeSelectionButton()
            }
        }
    }
}

///
/// Button is added in navigation bar to allow,
/// the user to change the current theme.
///
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

// MARK: - Hot switch Warning

/// Will be removed when hot switch will be supported
class HotSwitchWarningIndicator: ObservableObject {
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
            .alert("Warning", isPresented: $hotSwitchWarningIndicator.showAlert) {
            } message: {
                Text("You need to restart application to see design with new theme").odsFont(.title2)
            }
    }
}
