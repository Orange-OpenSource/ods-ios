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
    let componentList = [
        TextButtonComponentModel(name: "Buttons", image: "Shape_button") {
            ShapeButtonsList()
        },
        TextButtonComponentModel(name: "Text Buttons", image: "Text_button") {
            StandardButtonsList()
        },
        // TextButtonComponentModel(name: "Bars", image: "Bars"),
        TextButtonComponentModel(name: "Sliders", image: "Controls") {
            SliderPage()
        },
        // TextButtonComponentModel(name: "Modals", image: "Modals"),
        TextButtonComponentModel(name: "Card", image: "Card") {
            CardViewDemoSandbox()
        },
        TextButtonComponentModel(name: "Progress indicator", image: "Bars") {
            ProgressIndicatorPage()
        },
    ]

    let columns = [
        GridItem(.adaptive(minimum: 150), alignment: .topLeading),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(componentList) {
                        TextButtonComponent(component: $0)
                    }
                    .padding([.trailing])
                }
            }
            .padding([.leading, .top])
            .navigationTitle("Components")
            .navigationViewStyle(.stack)
        }
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
