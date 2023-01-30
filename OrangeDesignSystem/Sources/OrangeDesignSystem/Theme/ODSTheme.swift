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

public typealias ODSColorPalette = [ODSColorDecription]

///
/// Defines elements for an ODS Theme.
/// Default values are provided to define a `Default` fake theme
///
public struct ODSTheme: Identifiable, Hashable {

    // =======================
    // MARK: Stored Properties
    // =======================

    public var name: String
    public var colorPalette: ODSColorPalette
    public var componentColors: ODSComponentColors
    public var font: (_ style: ODSFontStyle) -> Font

    // ==================
    // MARK: Initializers
    // ==================

    public init() {
        name = "Default"
        colorPalette = ODSColorPalette()

        componentColors = ODSComponentColors()
        font = { style in
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
    }

    // ==================
    // MARK: Color access
    // ==================
    func color(_ assetName: String) -> Color? {
        colorPalette.first { $0.assetName == assetName }?.color
    }
    func color(_ name: String, for colorScheme: ColorScheme) -> Color? {
        colorPalette.first { $0.name(for: colorScheme) == name }?.color
    }

    // ==================
    // MARK: Identifiable
    // ==================
    public var id: String {
        name
    }

    // ==============
    // MARK: Hashable
    // ==============
    public static func == (lhs: ODSTheme, rhs: ODSTheme) -> Bool {
        lhs.name == rhs.name
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
