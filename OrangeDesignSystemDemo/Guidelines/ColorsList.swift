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

struct ColorList: View {

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ColourBigView(colour: ODSColour.coreOrange)
                    ColourBigView(colour: ODSColour.coreWhite)
                }
                HStack(spacing: 10) {
                    ColourBigView(colour: ODSColour.coreBlack)
                    ColourBigView(colour: ODSColour.coreObsGrey)
                }
            }
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ColourBigView(colour: ODSColour.functionalPositive)
                    ColourBigView(colour: ODSColour.functionalNegative)
                }
                HStack(spacing: 10) {
                    ColourBigView(colour: ODSColour.functionalAlert)
                    ColourBigView(colour: ODSColour.functionalInfo)
                }
            }
        }.padding(16)
    }
}

struct ColourBigView: View {
    let colour: ODSColour

    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .fill(colour.color)
                .aspectRatio(1.0, contentMode: .fit)
            Text(colour.onLightName)
            Text(colour.rgb)
            Text(colour.hexa)
            Spacer()
        }
    }
}

struct ColorSection: View {

    let colorType: ODSColor.ColorType
    let colors: [ODSColor]

    var body: some View {
        VStack(alignment: .leading) {
            Section(header:
                Text(colorType.description).font(ODSFontStyle.title3.font())
                    .frame(maxWidth: .infinity, minHeight: 40.0)
                    .foregroundColor(ODSColor.grey800.color)
                    .background(ODSColor.grey300.color)
            ) {
                ForEach(colors, id: \.name) { color in
                    ColorDescriptionView(odsColorDescription: color)
                }
            }
        }
    }
}

struct ColorDescriptionView: View {
    let odsColorDescription: ODSColor

    var body: some View {
        HStack(spacing: 20) {
            Rectangle()
                .foregroundColor(odsColorDescription.color)
                .frame(width: 30, height: 30)
                .padding(.leading, 20)
            Text(odsColorDescription.name)
            Spacer()
        }
    }
}

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorList().preferredColorScheme($0)
        }
    }
}
