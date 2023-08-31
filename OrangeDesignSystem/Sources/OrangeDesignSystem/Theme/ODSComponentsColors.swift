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

/// Used to define colors for components
public struct ODSComponentColors {

    // =======================
    // MARK: Stored Properties
    // =======================

    public var accent: Color

    // Navigation bar
    public var navigationBarTitle: Color
    public var navigationBarBackground: Color
    public var navigationBarForeground: Color

    // Tab bar
    public var tabBarBackground: Color
    public var tabBarItem: Color
    public var tabBarSelectedItem: Color

    // Tool bar
    public var toolBarBackground: Color
    public var toolBarItem: Color

    // Buttons
    public var highestEmphasisText: Color
    public var functionalPositive: Color
    public var functionalNegative: Color
    public var functionalAlert: Color
    public var functionalInfo: Color

    // Bottom sheet
    public var bottomSheetHeaderBackground: Color

    // ==================
    // MARK: Initializers
    // ==================

    public init() {
        self.accent = .pink

        // Navigation bar
        self.navigationBarTitle = .pink
        self.navigationBarBackground = .green
        self.navigationBarForeground = .pink

        // Tab bar
        self.tabBarBackground = .green
        self.tabBarItem = .pink
        self.tabBarSelectedItem = .primary

        // Tool bar
        self.toolBarBackground = .pink
        self.toolBarItem = .green

        // Buttons
        self.highestEmphasisText = Color(UIColor.systemBackground)
        self.functionalNegative = .red
        self.functionalPositive = .green
        self.functionalInfo = .blue
        self.functionalAlert = .yellow

        // Bottom sheet
        self.bottomSheetHeaderBackground = Color(UIColor.systemGray6)
    }
}
