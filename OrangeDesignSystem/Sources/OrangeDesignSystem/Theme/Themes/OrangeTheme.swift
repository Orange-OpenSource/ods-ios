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

// swiftlint:disable force_unwrapping
public enum OrangePalette {

    public static let Main1 = Color(UIColor(hex: "#ffDE2554")!)

    public static let Orange100 = Color(UIColor(hex: "#ffff7900")!)
    public static let Orange200 = Color(UIColor(hex: "#fff16e00")!)
    public static let White100 = Color(UIColor(hex: "#ffffffff")!)
    public static let Black900 = Color(UIColor(hex: "#ff000000")!)
    public static let ObsGrey700 = Color(UIColor(hex: "#ff595959")!)

    // Supporting colors

    public static let Blue100 = Color(UIColor(hex: "#ffB5E8F7")!)
    public static let Blue200 = Color(UIColor(hex: "#ff4BB4E6")!)
    public static let Blue300 = Color(UIColor(hex: "#ff085EBD")!)

    public static let Yellow100 = Color(UIColor(hex: "#ffFFF6B6")!)
    public static let Yellow200 = Color(UIColor(hex: "#ffFFD200")!)
    public static let Yellow300 = Color(UIColor(hex: "#ffFFB400")!)

    public static let Green100 = Color(UIColor(hex: "#ffB8EBD6")!)
    public static let Green200 = Color(UIColor(hex: "#ff50BE87")!)
    public static let Green300 = Color(UIColor(hex: "#ff0A6E31")!)

    public static let Purple100 = Color(UIColor(hex: "#ffD9C2F0")!)
    public static let Purple200 = Color(UIColor(hex: "#ffA885D8")!)
    public static let Purple300 = Color(UIColor(hex: "#ff492191")!)

    public static let Pink100 = Color(UIColor(hex: "#ffFFE8F7")!)
    public static let Pink200 = Color(UIColor(hex: "#ffFFB4E6")!)
    public static let Pink300 = Color(UIColor(hex: "#ffFF8AD4")!)

    // Functional colors

    public static let Info100 = Color(UIColor(hex: "#ff527EDB")!)
    public static let Info200 = Color(UIColor(hex: "#ff4170D8")!)
    public static let Alert100 = Color(UIColor(hex: "#ffFFCC00")!)
    public static let Alert200 = Color(UIColor(hex: "#ff8F7200")!)
    public static let Positive100 = Color(UIColor(hex: "#ff32C832")!)
    public static let Positive200 = Color(UIColor(hex: "#ff228722")!)
    public static let Negative100 = Color(UIColor(hex: "#ffD53F15")!)
    public static let Negative200 = Color(UIColor(hex: "#ffCD3C14")!)

    // Grey colors

    public static let Grey200 = Color(UIColor(hex: "#ffEEEEEE")!)
    public static let Grey300 = Color(UIColor(hex: "#ffDDDDDD")!)
    public static let Grey400 = Color(UIColor(hex: "#ffCCCCCC")!)
    public static let Grey500 = Color(UIColor(hex: "#ff999999")!)
    public static let Grey600 = Color(UIColor(hex: "#ff666666")!)
    public static let Grey800 = Color(UIColor(hex: "#ff333333")!)
}


public struct OrangeThemeFactory {
    public let theme: ODSTheme
    
    public init() {
        var theme = ODSTheme()
        
        theme.name = "OrangeTheme"
        theme.colors.accent = OrangePalette.Orange200
        
        theme.font = { style in
            switch style {
            case .largeTitle:
                return Font.largeTitle.bold()
            case .title1:
                return Font.title.bold()
            case .title2:
                return Font.title2.bold()
            case .title3:
                return Font.title3.bold()
            case .headline:
                return Font.headline.bold()
            case .bodyRegular:
                return Font.body
            case .bodyBold:
                return Font.body.bold()
            case .callout:
                return Font.callout
            case .subhead:
                return Font.subheadline.bold()
            case .footnote:
                return Font.footnote
            case .caption1Regular:
                return Font.caption
            case .caption1Bold:
                return Font.caption.bold()
            case .caption2:
                return Font.caption2
            }
        }
        
        self.theme = theme
    }
}
