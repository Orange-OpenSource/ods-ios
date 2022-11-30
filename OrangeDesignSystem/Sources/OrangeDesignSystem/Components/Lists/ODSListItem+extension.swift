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

struct ODSListItemLeadingIcon: View {

    let model: ODSListItemIcon

    var body: some View {
        switch model {
        case .icon(let image):
            image
        case .circularImage(let source):
            ODSListAsyncIcon(source: source)
                .clipShape(Circle())
        case .squareImage(let source):
            ODSListAsyncIcon(source: source)
                .clipShape(Rectangle())
        case .wideImage(let source):
            ODSListAsyncIcon(source: source)
        }
    }

    init(model: ODSListItemIcon) {
        self.model = model
    }
}

private struct ODSListAsyncIcon: View {
    let source: ODSListItemIcon.Source

    var body: some View {
        switch source {
        case let .asyncImage(url, placeHolder):
            AsyncImage(url: url) { image in
                image.iconModifier()
            } placeholder: {
                placeHolder.iconModifier()
            }
        case let .image(image):
            image.iconModifier()
        }
    }
}

extension Image {
    func iconModifier(height: CGFloat? = 44) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: height)
    }
}

struct ODSListItemTrailingIcon: View {

    @Environment(\.theme) private var theme
    
    let iconModel: ODSListItemTrailingIconModel

    var body: some View {
        switch iconModel {
        case let .text(text):
            Text(text)
                .odsFont(.subhead)
                .foregroundColor(Color(UIColor.systemGray3))

        case let .infoButton(onClicked):
            Image(systemName: "info.circle")
                .frame(width: 16, height: 16, alignment: .center)
                .foregroundColor(theme.componentColors.accent)
                .onTapGesture {
                    onClicked()
                }
        }
    }
}

struct ODSListItemModifier: ViewModifier {

    let minHeight: ODSListItemMinHeight

    func body(content: Content) -> some View {
        content
            .listRowInsets(EdgeInsets())
            .frame(minHeight: minHeight.rawValue)
    }
}
