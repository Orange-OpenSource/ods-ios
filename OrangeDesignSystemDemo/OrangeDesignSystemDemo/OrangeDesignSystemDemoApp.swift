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
import BottomSheet

@main
struct ods_ios_swiftUI_demoApp: App {
    @StateObject var themeProvider = ThemeProvider()
    @State var position: BottomSheetPosition = .dynamicBottom
    
    var body: some Scene {
        WindowGroup {
            ODSThemeableView(theme: themeProvider.currentTheme) {
                MainTabView().environmentObject(themeProvider)
            }
            .bottomSheet(bottomSheetPosition: $position, switchablePositions: [.dynamicBottom, .relative(0.5), .relative(0.95)]) {
                HStack(alignment: .center, spacing: ODSSpacing.xs) {
                    
                    VStack(alignment: .leading, spacing: ODSSpacing.none) {
                        Text("Title")
                            .odsFont(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        Text("Subtitle")
                            .odsFont(.subhead)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .background(.yellow)
                .padding(.bottom, ODSSpacing.s)
                .background(.blue)
                .onTapGesture {
                    self.position =  .dynamicBottom
                }
            } mainContent: {
                ContentBottomSheet(model: BottomSheetVariantModel())
            }
        }
    }
}
