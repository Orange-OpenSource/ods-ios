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

import OrangeDesignSystem
import SwiftUI

class ScreenState: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
}

struct ColorPageDescription: View {

    let screenState = ScreenState()

    var body: some View {
        VariantEntryItem(title: "ColorPalette", technicalElement: "ODSColorPalette()") {
            ColorList().environmentObject(self.screenState)
                .navigationTitle("ColorPalette")
        }
    }
}

fileprivate struct ColorList: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var phoneColorScheme
    @EnvironmentObject private var screenState: ScreenState

    private let columns = [
        GridItem(.flexible(minimum: 50.0)),
        GridItem(.flexible(minimum: 50.0))
    ]
    
    // ==========
    // MARK: Body
    // ==========

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
            }
            .padding(.top, ODSSpacing.s)

            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(theme.colorPalette, id: \.assetName) { colorDescription in
                        ColorIllustration(colorDescription: colorDescription,
                                          bordered: colorDescription.uiColor.rgba() == backGroundColor.rgba())
                    }
                }
                .padding(.horizontal, ODSSpacing.m)
                .padding(.vertical, ODSSpacing.m)
            }
            .background(Color(backGroundColor))
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    ColorUsage()
                } ) {
                    Text("Usage")
                }
                .foregroundColor(theme.componentColors.navigationBarForeground)
            }
        }
        .navigationTitle("Palette")
    }
    
    // ============================
    // MARK: Private Implementation
    // ============================

    private var backGroundColor: UIColor {
        screenState.colorScheme == .light ? .white : .black
    }
}

#if DEBUG
struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorPageDescription().environmentObject(ScreenState()).preferredColorScheme($0)
        }
    }
}
#endif
