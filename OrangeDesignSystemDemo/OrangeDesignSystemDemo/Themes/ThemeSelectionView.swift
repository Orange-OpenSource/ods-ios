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

    @Published var currentTheme: ODSTheme {
        didSet { UserDefaults.standard.set(currentTheme.name, forKey: "themeName") }
    }
    
    let themes: [ODSTheme]
    
    // ==================
    // MARK: Initializers
    // ==================

    init() {
        let orangeTheme = OrangeThemeFactory().theme
        themes = [orangeTheme,
                  InnovationCupThemeFactory().theme]

        if let themeName = UserDefaults.standard.value(forKey: "themeName") as? String,
            let theme = themes.first( where: { $0.name == themeName } ) {
            self.currentTheme = theme
        } else {
            self.currentTheme = orangeTheme
        }
    }
}

///
/// Theme selection view that allows the user to change
/// the current theme.
///
struct ThemeSelection: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    @EnvironmentObject var themeProvider: ThemeProvider

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ODSThemeableView(theme: themeProvider.currentTheme){
            VStack(spacing: ODSSpacing.l) {
                ODSChipPicker(title: "",
                              selection: $themeProvider.currentTheme,
                              chips: themeProvider.themes.map { theme in
                    ODSChip(theme, text: theme.name)
                })
                
                VStack {
                    Text("Selected theme:")
                        .odsFont(.bodyRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(themeProvider.currentTheme.name)
                        .foregroundColor(themeProvider.currentTheme.componentColors.accent)
                }
                .padding(.horizontal, ODSSpacing.m)
                
                Spacer()
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
