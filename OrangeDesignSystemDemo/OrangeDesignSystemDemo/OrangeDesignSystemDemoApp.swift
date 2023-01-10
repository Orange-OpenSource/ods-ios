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

@main
struct ods_ios_swiftUI_demoApp: App {
    @StateObject var themeProvider = ThemeProvider()
    
    var body: some Scene {
        WindowGroup {
            ODSThemeableView(theme: themeProvider.currentTheme) {
                MainTabView().environmentObject(themeProvider)
            }
//            MyView()
        }
    }
}

struct MyView: View {
    init() {
        let coloredAppearance = UIToolbarAppearance()
         coloredAppearance.configureWithOpaqueBackground()
         coloredAppearance.backgroundColor = .systemRed
                
        UIToolbar.appearance().standardAppearance = coloredAppearance
        UIToolbar.appearance().compactAppearance = coloredAppearance
        UIToolbar.appearance().scrollEdgeAppearance = coloredAppearance
         
         UIToolbar.appearance().tintColor = .white
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("coucou")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        
                    } label: {
                        Text("First")
                    }
                }
            }
            .modifier(MyModifier())

        }
    }
}

struct MyModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .toolbarBackground(.red, for: .bottomBar)
        } else {
            content
        }
    }
}

