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

class ScreenState: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
}

struct ColorList: View {

    // MARK: - Dark/Light managment
    @Environment(\.colorScheme) var phoneColorScheme: ColorScheme
    @EnvironmentObject var screenState: ScreenState

    // MARK: - Body
    var body: some View {
        VStack {
            Group {
                Picker("Favorite Scheme", selection: $screenState.colorScheme, content: {
                    Text("On Light").tag(ColorScheme.light)
                    Text("On Dark").tag(ColorScheme.dark)
                })
                .pickerStyle(.segmented)
                .onAppear {
                    screenState.colorScheme = phoneColorScheme
                }
                .padding(EdgeInsets(top: ODSSpacing.s, leading: ODSSpacing.m, bottom: ODSSpacing.xs, trailing: ODSSpacing.m))
            }.padding(.top, ODSSpacing.s)

            ScrollView {
                SectionTitle(title: "Core")

                VStack {
                    HStack(spacing: ODSSpacing.m) {
                        ColorBig(color: ODSColor.coreOrange, bordered: false)
                        ColorBig(color: ODSColor.coreWhite, bordered: screenState.colorScheme == .light)
                    }
                    HStack(spacing: ODSSpacing.m) {
                        ColorBig(color: ODSColor.coreBlack, bordered: screenState.colorScheme == .dark)
                        ColorBig(color: ODSColor.coreObsGrey, bordered: false)
                    }
                }
                .padding(EdgeInsets(top: ODSSpacing.l, leading: ODSSpacing.m, bottom: ODSSpacing.xs, trailing: ODSSpacing.m))

                SectionTitle(title: "Functional")
                    .padding(.top, ODSSpacing.l)

                VStack {
                    HStack(spacing: ODSSpacing.m) {
                        ColorBig(color: ODSColor.functionalPositive, bordered: false)
                        ColorBig(color: ODSColor.functionalNegative, bordered: false)
                    }
                    HStack(spacing: ODSSpacing.m) {
                        ColorBig(color: ODSColor.functionalAlert, bordered: false)
                        ColorBig(color: ODSColor.functionalInfo, bordered: false)
                    }
                }
                .padding(EdgeInsets(top: ODSSpacing.none, leading: ODSSpacing.m, bottom: ODSSpacing.xs, trailing: ODSSpacing.m))

                SectionTitle(title: "Supporting")
                    .padding(.top, ODSSpacing.l)

                VStack {
                    HStack(spacing: ODSSpacing.m) {
                        ColorSmall(color: ODSColor.supportingBlue100)
                        ColorSmall(color: ODSColor.supportingBlue200)
                        ColorSmall(color: ODSColor.supportingBlue300)
                    }
                    HStack(spacing: ODSSpacing.m) {
                        ColorSmall(color: ODSColor.supportingYellow100)
                        ColorSmall(color: ODSColor.supportingYellow200)
                        ColorSmall(color: ODSColor.supportingYellow300)
                    }
                    HStack(spacing: ODSSpacing.m) {
                        ColorSmall(color: ODSColor.supportingGreen100)
                        ColorSmall(color: ODSColor.supportingGreen200)
                        ColorSmall(color: ODSColor.supportingGreen300)
                    }
                    HStack(spacing: ODSSpacing.m) {
                        ColorSmall(color: ODSColor.supportingPink100)
                        ColorSmall(color: ODSColor.supportingPink200)
                        ColorSmall(color: ODSColor.supportingPink300)
                    }
                    HStack(spacing: ODSSpacing.m) {
                        ColorSmall(color: ODSColor.supportingPurple100)
                        ColorSmall(color: ODSColor.supportingPurple200)
                        ColorSmall(color: ODSColor.supportingPurple300)
                    }
                }
                .padding(.vertical, ODSSpacing.xs)
                .padding(.horizontal, ODSSpacing.m)
            }
            .background(screenState.colorScheme == .light ? Color.white : Color.black)
            .padding(.bottom, ODSSpacing.m)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ColorUsage()) {
                    Text("Usage")
                }
                .foregroundColor(ODS.coreOrange)
            }
        }
        .navigationTitle("Palette")
    }
}

struct SectionTitle: View {
    var title: String
    @EnvironmentObject var screenState: ScreenState

    var body: some View {
        Text(title)
            .odsFont(.title1)
            .foregroundColor(screenState.colorScheme == .dark ? Color.white : Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: ODSSpacing.s, leading: ODSSpacing.m, bottom: ODSSpacing.xs, trailing: ODSSpacing.m))
    }
}

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorList().environmentObject(ScreenState()).preferredColorScheme($0)
        }
    }
}
