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

public enum ODSFontStyle: String, CaseIterable {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case bodyBold
    case bodyRegular
    case callout
    case subhead
    case footnote
    case caption1Bold
    case caption1Regular
    case caption2

    public func font() -> Font {
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
        case .bodyBold:
            return Font.body.bold()
        case .bodyRegular:
            return Font.body
        case .callout:
            return Font.callout
        case .subhead:
            return Font.subheadline.bold()
        case .footnote:
            return Font.footnote
        case .caption1Bold:
            return Font.caption.bold()
        case .caption1Regular:
            return Font.caption
        case .caption2:
            return Font.caption2
        }
    }
}

extension Text {
    public func odsFont(style: ODSFontStyle, fixed: Bool = false) -> Text {

        if fixed {
            if let text = font(style.font()).dynamicTypeSize(.medium) as? Text {
                return text
            }
            return self

        } else {
            return font(style.font())
        }
    }
}

extension TextEditor {
    public func odsFont(style: ODSFontStyle, fixed: Bool = false) -> TextEditor {

        if fixed {
            if let text = font(style.font()).dynamicTypeSize(.medium) as? TextEditor {
                return text
            }
            return self

        } else {
            return font(style.font()) as? TextEditor ?? self
        }
    }
}
