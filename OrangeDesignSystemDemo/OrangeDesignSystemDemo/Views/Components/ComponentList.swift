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

struct ComponentsList: View {

    // Remark: Components are automatically displayed sorted by their name
    let componentList = [
        ODSSmallCardModel(title: "Bars - tab", image: Image("Tab bar")) {
            TabBarPage().modifier(ComponentModifier(title: "Bars - tab"))
        },
        ODSSmallCardModel(title: "Buttons", image: Image("Buttons - Shape")) {
            ButtonPage().modifier(ComponentModifier(title: "Buttons"))
        },
        ODSSmallCardModel(title: "Cards", image: Image("Cards_1")) {
            CardPage().modifier(ComponentModifier(title: "Cards"))
        },
        ODSSmallCardModel(title: "Chips", image: Image("Chips")) {
            ChipsPage().modifier(ComponentModifier(title: "Chips"))
        },
        ODSSmallCardModel(title: "Lists", image: Image("Lists")) {
            ListPage().modifier(ComponentModifier(title: "Lists"))
        },
        ODSSmallCardModel(title: "Progress indicators", image: Image("Progress_indicator")) {
            ProgressIndicatorPage().modifier(ComponentModifier(title: "Progress indicators"))
        },
        ODSSmallCardModel(title: "Sliders", image: Image("Slider")) {
            SliderPage().modifier(ComponentModifier(title: "Sliders"))
        },
        ODSSmallCardModel(title: "Text field", image: Image("Text edit menu")) {
            TextFieldPage().modifier(ComponentModifier(title: "Text field"))
        },
        ODSSmallCardModel(title: "Bars - navigation", image: Image("Navigation bars")) {
            NavigationBarPage().modifier(ComponentModifier(title: "Bars - navigation"))
        },
    ]

    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: ODSSpacing.m, alignment: .topLeading),
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                ODSGridOfCards(cardModels: componentList)
                    .padding(.vertical, ODSSpacing.m)
                    .padding(.horizontal, ODSSpacing.s)
            }
            .navigationTitle("Components")
            .navigationViewStyle(.stack)
        }
        .background(ODSColor.primaryBackground.color)
    }
}

struct ComponentModifier: ViewModifier {
    init(title: String) {
        self.title = title
    }

    let title: String

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationViewStyle(.stack)
            .background(Color(uiColor: .systemGray6))
    }
}

#if DEBUG
struct ComponentsCardsList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ComponentsList()
                .preferredColorScheme($0)
        }
    }
}
#endif
