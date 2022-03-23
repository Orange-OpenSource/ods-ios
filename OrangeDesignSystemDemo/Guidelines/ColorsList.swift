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

    // MARK: - Dark/Light managment
    @Environment(\.colorScheme) var phoneColorScheme: ColorScheme
    @State var selectedTheme = 0 // Any value : overwritten when View.onAppear
    @State var screenColorScheme: ColorScheme = .light

    func initColorScheme() {
        if phoneColorScheme == .light {
            screenColorScheme = .light
            selectedTheme = 0
        } else {
            screenColorScheme = .dark
            selectedTheme = 1
        }
    }

    func setColorScheme() {
        screenColorScheme = selectedTheme == 0 ? .light : .dark
    }

    // MARK: - Body
    var body: some View {
        VStack {
            Picker("Favorite Color", selection: $selectedTheme, content: {
                Text("on Light").tag(0)
                Text("on Dark").tag(1)
            }).pickerStyle(.segmented)
                .onAppear {
                    initColorScheme()
                }.onChange(of: selectedTheme, perform: { _ in
                    setColorScheme()
                }).padding(16)

            ScrollView {

                VStack {
                    HStack(spacing: 19) {
                        ColourBigView(colour: ODSColour.coreOrange, scheme: screenColorScheme)
                        ColourBigView(colour: ODSColour.coreWhite, scheme: screenColorScheme)
                    }
                    HStack(spacing: 19) {
                        ColourBigView(colour: ODSColour.coreBlack, scheme: screenColorScheme)
                        ColourBigView(colour: ODSColour.coreObsGrey, scheme: screenColorScheme)
                    }
                }
                VStack {
                    HStack(spacing: 19) {
                        ColourBigView(colour: ODSColour.functionalPositive, scheme: screenColorScheme)
                        ColourBigView(colour: ODSColour.functionalNegative, scheme: screenColorScheme)
                    }
                    HStack(spacing: 19) {
                        ColourBigView(colour: ODSColour.functionalAlert, scheme: screenColorScheme)
                        ColourBigView(colour: ODSColour.functionalInfo, scheme: screenColorScheme)
                    }
                }
            }.padding(16)
        }.background(ODSColor.coreTheme.color)
            .colorScheme(screenColorScheme)
    }
}

struct ColourBigView: View {
    let colour: ODSColour
    let scheme: ColorScheme

    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(colour.color)
                .aspectRatio(1.0, contentMode: .fit)
            Text(colour.name(forScheme: scheme)).odsFont(style: .headline)
            Text(colour.internalName).odsFont(style: .subhead)
            Text(colour.rgb).odsFont(style: .caption1Regular)
            Text(colour.hexa).odsFont(style: .caption1Regular)
        }
    }
}

// struct ColorSection: View {
//
//    let colorType: ODSColor.ColorType
//    let colors: [ODSColor]
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Section(header:
//                Text(colorType.description).font(ODSFontStyle.title3.font())
//                    .frame(maxWidth: .infinity, minHeight: 40.0)
//                    .foregroundColor(ODSColor.grey800.color)
//                    .background(ODSColor.grey300.color)
//            ) {
//                ForEach(colors, id: \.name) { color in
//                    ColorDescriptionView(odsColorDescription: color)
//                }
//            }
//        }
//    }
// }
//
// struct ColorDescriptionView: View {
//    let odsColorDescription: ODSColor
//
//    var body: some View {
//        HStack(spacing: 20) {
//            Rectangle()
//                .foregroundColor(odsColorDescription.color)
//                .frame(width: 30, height: 30)
//                .padding(.leading, 20)
//            Text(odsColorDescription.name)
//            Spacer()
//        }
//    }
// }

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorList().preferredColorScheme($0)
        }
    }
}
