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

    let model: ODSListItemLeadingIconModel
    let height: CGFloat?

    var body: some View {
        switch model {
        case let .withImage(image):
            image.iconModifier(height: height)
        case let .withUrl(url, placeHolder):
            AsyncImage(url: url) { image in
                image.iconModifier(height: height)
            } placeholder: {
                placeHolder.iconModifier(height: height)
            }
        }
    }

    init(model: ODSListItemLeadingIconModel, height: CGFloat?) {
        self.model = model
        self.height = height
    }
}

extension Image {
    func iconModifier(height: CGFloat? = 44) -> some View {
        resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.vertical, ODSSpacing.s)
            .frame(height: height)
    }
}

struct ODSListItemTrailingIcon: View {

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
                .foregroundColor(ODSColor.coreOrange.color)
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
