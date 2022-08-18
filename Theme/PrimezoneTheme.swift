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
import UIKit

public enum PrimezonePalette {
    
    public static let Main1 = Color(UIColor(hex: "#ffDE2554")!)
    public static let Main1Pressed = Color(UIColor(hex: "#ffDE2555")!)
    public static let Main2 = Color(UIColor(hex: "#ffFBCD00")!)
    public static let Blue = Color(UIColor(hex: "#4BB4E6")!)

    public static let White100 = Color(UIColor(hex: "#ffffffff")!)
    public static let Black900 = Color(UIColor(hex: "#ff000000")!)

    public static let Grey1 = Color(UIColor(hex: "#ff333333")!)
    public static let Grey2 = Color(UIColor(hex: "#ffEEEEEE")!)
    public static let Grey3 = Color(UIColor(hex: "#ff555555")!)
    public static let Grey4 = Color(UIColor(hex: "#ffCCCCCC")!)

    public static let FunctionalSuccess = Color(UIColor(hex: "#ff3DE35A")!)
    public static let FunctionalError = Color(UIColor(hex: "#ffE70002")!)
    public static let FunctionalInfo = Color(UIColor(hex: "#ff26B2FF")!)
    public static let FunctionalWarning = Color(UIColor(hex: "#ffFFCD0B")!)

    public static let FunctionalSuccess10 = Color(UIColor(hex: "#ffECFDEF")!)
    public static let FunctionalError10 = Color(UIColor(hex: "#ffFDE5E6")!)
    public static let FunctionalInfo10 = Color(UIColor(hex: "#ffE9F8FF")!)
    public static let FunctionalWarning10 = Color(UIColor(hex: "#ffFFFAE7")!)

    public static let FunctionalSuccess20 = FunctionalSuccess10
    public static let FunctionalError20 = FunctionalError10
    public static let FunctionalInfo20 = FunctionalInfo10
    public static let FunctionalWarning20 = FunctionalWarning10

    public static let FunctionalSuccess30 = FunctionalSuccess10
    public static let FunctionalError30 = FunctionalError10
    public static let FunctionalInfo30 = FunctionalInfo10
    public static let FunctionalWarning30 = FunctionalWarning10

    public static let CapsuleSuccessColor = Color(UIColor(hex: "#ff3DE35A")!)
    public static let CapsuleErrorColor = Color(UIColor(hex: "#ffEEEEEE")!)
    public static let CapsuleErrorOnDarkColor = Color(UIColor(hex: "#ff555555")!)
    public static let CapsuleInactiveColor = Color(UIColor(hex: "#ffDDDDDD")!)

    public static let DarkCapsuleSuccessColor = CapsuleSuccessColor
    public static let DarkCapsuleErrorColor = Color(UIColor(hex: "#ff444444")!)
    public static let DarkCapsuleInactiveColor = Color(UIColor(hex: "#ff555555")!)

    public static let Yellow2 = Color(UIColor(hex: "#FFFFCC00")!)
    public static let Magenta2 = Color(UIColor(hex: "#FFBF51A0")!)

    public static let DarkSurfaceDefault = Color(UIColor(hex: "#ff1A2228")!)
    public static let DarkDisabled = Color(UIColor(hex: "#ff444444")!)
}

public class PrimezoneTheme: ODSTheme {
    
    public let name: String
    public let colors: ODSThemeColors
    
    required public init() {
        name = "Primezone"
        colors = ODSThemeColors(coreSurface: PrimezonePalette.White100,
                                coreOnSurface: PrimezonePalette.Black900,
                                systemStatusBarBackground: PrimezonePalette.Blue,
                                systemNavigationBarBackground: PrimezonePalette.Black900,
                                componentBackgroundDisabled: PrimezonePalette.Grey4,
                                componentContentDisabled: PrimezonePalette.White100,
                                topBarBackground: PrimezonePalette.Blue,
                                topBarContent: PrimezonePalette.White100,
                                bottomNavigationBarBackground: PrimezonePalette.Black900,
                                bottomNavigationBarContent: PrimezonePalette.White100,
                                bottomNavigationBarContentSelected: PrimezonePalette.Blue,
                                cardBackground: PrimezonePalette.Black900,
                                cardContent: PrimezonePalette.White100)
    }

    /// Font associated to ODSFontStyle
    public func font(for style: ODSThemeFontStyle) -> Font {
        switch style {
        case .largeTitle:
            return Font.custom("Snell Roundhand", size: 34).bold()
        case .title1:
            return Font.custom("Snell Roundhand", size: 28).bold()
        case .title2:
            return Font.custom("Snell Roundhand", size: 22).bold()
        case .title3:
            return Font.custom("Snell Roundhand", size: 20).bold()
        case .headline:
            return Font.custom("Snell Roundhand", size: 17).bold()
        case .bodyRegular:
            return Font.custom("Snell Roundhand", size: 17)
        case .bodyBold:
            return Font.custom("Snell Roundhand", size: 17).bold()
        case .callout:
            return Font.custom("Snell Roundhand", size: 16)
        case .subhead:
            return Font.custom("Snell Roundhand", size: 15)
        case .footnote:
            return Font.custom("Snell Roundhand", size: 13)
        case .caption1Regular:
            return Font.custom("Snell Roundhand", size: 12)
        case .caption1Bold:
            return Font.custom("Snell Roundhand", size: 12).bold()
        case .caption2:
            return Font.custom("Snell Roundhand", size: 11)
        }
    }
}
