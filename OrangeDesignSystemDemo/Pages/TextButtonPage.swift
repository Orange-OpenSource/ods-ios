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
import OrangeDesignSystem
import SwiftUI

struct TextButtonPage: View {

    var body: some View {
        ScrollView {
            Image("Buttons - Standard")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack(alignment: .leading, spacing: ODSSpacing.l) {
                ComponentDescription(text: "Plain buttons are the most ubiquitous component found throughout applications. Consisting of either a text label or an icon, they are the most simple button style.")
                VariantsTitle()
                IconButton(name: "Icon (add)", imageName: "plus.circle")
                IconButton(name: "Icon (info)", imageName: "info.circle")
                LabelButton().padding(.bottom, ODSSpacing.s)
            }
            .padding(EdgeInsets(top: ODSSpacing.none, leading: ODSSpacing.m, bottom: ODSSpacing.xs, trailing: ODSSpacing.m))
        }
        .background(ODSColor.primaryBackground.color)
    }
}

private struct LabelButton: View {

    var body: some View {

        Text("Label")
            .odsFont(.title2)
        VStack(alignment: .center) {
            Button {} label: {
                ODSGenericButtonContent(topText: "Label button", textColor: ODS.coreOrange)
            }
            .frame(maxWidth: .infinity)
            .padding([.bottom], ODSSpacing.m)
        }
        .padding([.leading, .trailing], ODSSpacing.xxl)
    }
}

private struct IconButton: View {

    let name: String
    let imageName: String

    var body: some View {
        Text(name)
            .odsFont(.title2)
        VStack(alignment: .center) {
            Button {} label: {
                ODSGenericButtonContent(imageDescription: ODSImageDescription(image: Image(systemName: imageName).renderingMode(.template), imageWidth: 30, imageHeight: 30, foregroundColor: ODS.coreOrange))
            }
            .frame(maxWidth: .infinity)
            .padding([.bottom], ODSSpacing.m)
        }
        .padding([.leading, .trailing], ODSSpacing.xxl)
    }
}

struct TextButtonPage_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TextButtonPage()
                .preferredColorScheme($0)
        }
    }
}
