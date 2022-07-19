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

import Foundation
import SwiftUI

/// Defines all styles supported by Orange application for Text elements.
public enum ODSFontStyle: String, CaseIterable {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case bodyRegular
    case bodyBold
    case callout
    case subhead
    case footnote
    case caption1Regular
    case caption1Bold
    case caption2

    /// Font associated to ODSFontStyle
    public var font: Font {
        switch self {
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

extension View {
    /// Sets the font for text in this view defined by the __ODSFontStyle__
    ///
    /// - Parameter odsStyle: The default ods font style to use in this view.
    ///
    /// - Returns: A view with the default font set to the value you supply.
    ///
    /// @see font(_ font: Font?) -> some View
    @inlinable public func odsFont(_ odsStyle: ODSFontStyle) -> some View {
        font(odsStyle.font)
    }
}
