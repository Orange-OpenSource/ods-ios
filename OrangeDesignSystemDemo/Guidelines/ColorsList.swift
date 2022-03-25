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
                Text("On Light").tag(0)
                Text("On Dark").tag(1)
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
            }.padding(16).background(screenColorScheme == .light ? Color.white : Color.black)
        }
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
            Text(colour.displayName(forScheme: scheme)).odsFont(style: .headline)
            Text(colour.rawValue).odsFont(style: .caption1Regular)
            Text(colour.rgb(forScheme: scheme).toString()).odsFont(style: .caption1Regular)
            Text(colour.hexa(forScheme: scheme)).odsFont(style: .caption1Regular)
        }.background(Color(uiColor: UIColor.systemBackground)).colorScheme(scheme)
    }
}

struct ColourSmallView: View {
    let colour: ODSColour
    let scheme: ColorScheme

    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(colour.color)
                .aspectRatio(1.0, contentMode: .fit)
            Text(colour.displayName(forScheme: scheme)).odsFont(style: .headline)
            Text(colour.rawValue).odsFont(style: .caption1Regular)
            Text(colour.rgb(forScheme: scheme).toString()).odsFont(style: .caption1Regular)
            Text(colour.hexa(forScheme: scheme)).odsFont(style: .caption1Regular)
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
