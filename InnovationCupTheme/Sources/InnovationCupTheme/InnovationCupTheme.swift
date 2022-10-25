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
import OrangeDesignSystem

public struct InnovationCupThemeFactory {
    public let theme: ODSTheme

    public init() {
        var theme = ODSTheme()
        theme.name = "InnovationCup"

        theme.colors.accent = Color("accent", bundle: Bundle.module)

        // Navigation bar
        theme.colors.navigationBarTitle = Color.white
        theme.colors.navigationBarBackground = theme.colors.accent
        theme.colors.navigationBarForeground = Color.white
        
        // Tab bar
        theme.colors.tabBarBackground = theme.colors.accent
        theme.colors.tabBarItem = Color("tabBarItem", bundle: Bundle.module)
        theme.colors.tabBarSelectedItem = .white
                
        // Buttons
        theme.colors.highestEmphasisText = .white
        theme.colors.functionalNegative = Color("functionalNegative", bundle: Bundle.module)
        theme.colors.functionalPositive = Color("functionalPositive", bundle: Bundle.module)

        // Fonts: use the default ones
        // theme.font = { style in }
    
        self.theme = theme
    }
}
