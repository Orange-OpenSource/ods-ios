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

struct ODSListItemLeftIcon: View {

    let iconModel: ODSListItemLeftIconModel
    let iconHeight: CGFloat?

    var body: some View {
        switch iconModel {
        case let .withImage(image):
            image.iconModifier(height: iconHeight)
        case let .withUrl(url, placeHolder):
            AsyncImage(url: url) { image in
                image.iconModifier(height: iconHeight)
            } placeholder: {
                placeHolder.iconModifier(height: iconHeight)
            }
        }
    }

    init(iconModel: ODSListItemLeftIconModel, iconHeight: CGFloat?) {
        self.iconModel = iconModel
        self.iconHeight = iconHeight
    }
}

extension Image {
    func iconModifier(height: CGFloat? = 44) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .frame(height: height)
    }
}

struct ODSListItemRightIcon: View {

    let iconModel: ODSListItemRightIconModel

    var body: some View {
        switch iconModel {
        case let .chevron(text):
            HStack {
                if let text = text {
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor.systemGray3))
                }
                ChevronView()
            }
            
        case let .text(text):
            Text(text)
                .font(.subheadline)
                .foregroundColor(Color(UIColor.systemGray3))
            
        case let .toggle(binding):
            Toggle("", isOn: binding).tint(ODS.coreOrange)
        }
    }
}

// =======================
// MARK: Internal Helpers
// =======================
extension Image {
    func imageIconModifier(color: Color = Color.primary, width: CGFloat? = 32, height: CGFloat? = 32) -> some View {
        resizable()
            .renderingMode(.template)
            .foregroundColor(color)
            .frame(width: width, height: height)
    }
}

struct ODSListItemModifier: ViewModifier {
    
    let minHeight: ODSListItemMinHeight
    
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .frame(minHeight: minHeight.rawValue)
    }
}

struct ChevronView: View {

    @Environment(\.layoutDirection) var layoutDirection: LayoutDirection

    var chevronImageName: String {
        switch layoutDirection {
        case .leftToRight:
            return "chevron.right"
        case .rightToLeft:
            return "chevron.left"
        @unknown default:
            return "chevron.right"
        }
    }

    var body: some View {
        Image(systemName: chevronImageName)
            .renderingMode(.template)
            .foregroundColor(Color.secondary)
            .font(Font.system(.footnote).weight(.semibold))
    }
}
