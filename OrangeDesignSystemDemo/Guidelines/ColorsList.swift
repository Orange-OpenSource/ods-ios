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
    @State var selectedTheme: ColorScheme = .light // Any value : overwritten when View.onAppear
    @State private var screenColorScheme: ColorScheme = .light

    // MARK: - Body
    var body: some View {
        VStack {
            Picker("Favorite Scheme", selection: $screenColorScheme, content: {
                Text("On Light").tag(ColorScheme.light)
                Text("On Dark").tag(ColorScheme.dark)
            }).pickerStyle(.segmented)
                .onAppear {
                    screenColorScheme = phoneColorScheme
                }.padding(16)
            ScrollView {
                SectionTitle(title: "Core", scheme: $screenColorScheme)
                VStack {
                    HStack(spacing: 19) {
                        colorBigView(color: ODSColor.coreOrange, scheme: $screenColorScheme, bordered: false)
                        colorBigView(color: ODSColor.coreWhite, scheme: $screenColorScheme, bordered: screenColorScheme == .light)
                    }
                    HStack(spacing: 19) {
                        colorBigView(color: ODSColor.coreBlack, scheme: $screenColorScheme, bordered: screenColorScheme == .dark)
                        colorBigView(color: ODSColor.coreObsGrey, scheme: $screenColorScheme, bordered: false)
                    }
                }
                SectionTitle(title: "Functional", scheme: $screenColorScheme)
                VStack {
                    HStack(spacing: 19) {
                        colorBigView(color: ODSColor.functionalPositive, scheme: $screenColorScheme, bordered: false)
                        colorBigView(color: ODSColor.functionalNegative, scheme: $screenColorScheme, bordered: false)
                    }
                    HStack(spacing: 19) {
                        colorBigView(color: ODSColor.functionalAlert, scheme: $screenColorScheme, bordered: false)
                        colorBigView(color: ODSColor.functionalInfo, scheme: $screenColorScheme, bordered: false)
                    }
                }
                SectionTitle(title: "Supporting", scheme: $screenColorScheme)
                VStack {
                    HStack(spacing: 19) {
                        colorSmallView(color: ODSColor.supportingBlue100, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingBlue200, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingBlue300, scheme: $screenColorScheme)
                    }
                    HStack(spacing: 19) {
                        colorSmallView(color: ODSColor.supportingYellow100, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingYellow200, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingYellow300, scheme: $screenColorScheme)
                    }
                    HStack(spacing: 19) {
                        colorSmallView(color: ODSColor.supportingGreen100, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingGreen200, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingGreen300, scheme: $screenColorScheme)
                    }
                    HStack(spacing: 19) {
                        colorSmallView(color: ODSColor.supportingPink100, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingPink200, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingPink300, scheme: $screenColorScheme)
                    }
                    HStack(spacing: 19) {
                        colorSmallView(color: ODSColor.supportingPurple100, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingPurple200, scheme: $screenColorScheme)
                        colorSmallView(color: ODSColor.supportingPurple300, scheme: $screenColorScheme)
                    }
                }
            }.padding(16).background(screenColorScheme == .light ? Color.white : Color.black)
        }
    }
}

struct SectionTitle: View {
    var title: String
    @Binding var scheme: ColorScheme

    var body: some View {
        Spacer().frame(height: 30)
        Text(title).odsFont(style: .title2)
            .foregroundColor(scheme == .dark ? Color.white : Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct colorBigView: View {
    let color: ODSColor
    @Binding var scheme: ColorScheme
    var bordered: Bool

    var body: some View {
        VStack(alignment: .leading) {
            if bordered {
                Rectangle()
                    .fill(color.color)
                    .border(Color.secondary)
                    .aspectRatio(1.0, contentMode: .fit)
            } else {
                Rectangle()
                    .fill(color.color)
                    .aspectRatio(1.0, contentMode: .fit)
            }
            Text(color.displayName(forScheme: scheme)).odsFont(style: .headline)
            Text(color.rawValue).odsFont(style: .caption1Regular)
            Text(color.rgb(forScheme: scheme).toString()).odsFont(style: .caption1Regular)
            Text(color.hexa(forScheme: scheme)).odsFont(style: .caption1Regular)
        }.background(Color(uiColor: UIColor.systemBackground)).colorScheme(scheme)
    }
}

struct colorSmallView: View {
    let color: ODSColor
    @Binding var scheme: ColorScheme

    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(color.color)
                .aspectRatio(1.0, contentMode: .fit)
            Text(color.displayName(forScheme: scheme)).odsFont(style: .headline)
            Text(color.hexa(forScheme: scheme)).odsFont(style: .caption1Regular)
        }.background(Color(uiColor: UIColor.systemBackground)).colorScheme(scheme)
    }
}

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorList().preferredColorScheme($0)
        }
    }
}
