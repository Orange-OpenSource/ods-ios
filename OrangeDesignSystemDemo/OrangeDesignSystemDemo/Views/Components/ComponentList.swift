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

struct ComponentsCardsList: View {
    // Remark: Components are automatically displayed sorted by their name
    let componentList = [
        ComponentModel(name: "Bars - tab", image: "Tab bar") {
            TabBarPage()
        },
        ComponentModel(name: "Buttons - standard", image: "Buttons - Standard") {
            TextButtonPage()
        },
        ComponentModel(name: "Buttons - shape", image: "Buttons - Shape") {
            ShapeButtonPage()
        },
        ComponentModel(name: "Cards", image: "Cards_1") {
            CardPage()
        },
        ComponentModel(name: "Chips", image: "Chips") {
            ChipsPage()
        },
        ComponentModel(name: "Progress indicators", image: "Progress_indicator") {
            ProgressIndicatorPage()
        },
        ComponentModel(name: "Sliders", image: "Slider") {
            SliderPage()
        },
        ComponentModel(name: "Text selection", image: "Text edit menu") {
            TextSelectionPage()
        },
    ]

    let columns = [
        GridItem(.adaptive(minimum: 150), alignment: .topLeading),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                ODSSpacer(.m)
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(componentList.sorted { $0.name < $1.name }) {
                        Component(component: $0)
                    }
                }.padding([.leading, .trailing])
                ODSSpacer(.m)
            }
            .navigationTitle("Components")
            .navigationViewStyle(.stack)
        }.background(ODSColor.primaryBackground.color)
    }
}

struct ComponentsCardsList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ComponentsCardsList()
                .preferredColorScheme($0)
        }
    }
}
