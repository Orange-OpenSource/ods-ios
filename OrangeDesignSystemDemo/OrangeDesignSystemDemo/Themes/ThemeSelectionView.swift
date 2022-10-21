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

import Combine
import OrangeDesignSystem
import InnovationCupTheme
import MyOdsTheme
import OrangeTheme
import SwiftUI

class ThemeProvider: ObservableObject {
        
    @Published var currentTheme: ODSTheme {
        didSet { UserDefaults.standard.set(currentTheme.name, forKey: "themeName") }
    }
    
    let themes: [ODSTheme]
    init() {
        let orangeTheme = OrangeThemeFactory().theme
        themes = [orangeTheme,
                  MyOdsThemeFactory().theme,
                  InnovationCupThemeFactory().theme]

        if let themeName = UserDefaults.standard.value(forKey: "themeName") as? String,
            let theme = themes.first( where: { $0.name == themeName } ) {
            self.currentTheme = theme
        } else {
            self.currentTheme = orangeTheme
        }
    }
}

struct ThemeSelection: View {
    var body: some View {
        ThemeSelectionInner()
    }
}

struct ThemeSelectionInner: View {
    @EnvironmentObject var themeProvider: ThemeProvider

    var body: some View {
        VStack {
            ODSChipPicker(title: "Theme selection",
                          selection: $themeProvider.currentTheme,
                          chips: themeProvider.themes.map { theme in
                ODSChip(theme, text: theme.name)
            })
            .tint(themeProvider.currentTheme.colors.accent)
            
            
            Text("Selected theme")
                .odsFont(.bodyRegular)
                .foregroundColor(themeProvider.currentTheme.colors.accent)

            Spacer()
        }
    }
}
