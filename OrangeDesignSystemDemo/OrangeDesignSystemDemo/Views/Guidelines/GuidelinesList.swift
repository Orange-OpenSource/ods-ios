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
import OrangeTheme

struct GuidelinesList: View {
    
    @Environment(\.theme) private var theme
    
    private var items: [ODSListOfCardImageFirstItemModel] {
        var items: [ODSListOfCardImageFirstItemModel] = []
        
        if theme.name == OrangeThemeFactory.themeName {
            items = [ODSListOfCardImageFirstItemModel(cardModel: ODSCardImageFirstModel(title: "Colours", image: Image("Colour"))) {
                ColorPage()
            }]
        }

        items.append(contentsOf:
            [ ODSListOfCardImageFirstItemModel(cardModel: ODSCardImageFirstModel(title: "Typography", image: Image("Typography"))) {
                TypographyPage()
            },
              
              ODSListOfCardImageFirstItemModel(cardModel: ODSCardImageFirstModel(title: "Spacings", image: Image("Spacing"))) {
                  SpacingPage()
              },
            ]
        )
        
        return items
    }

    var body: some View {
        NavigationView {
            ODSListOfCardImageFirst(title: "Guidelines", itemModels: items)
                .navigationTitle("Guidelines")
                .navigationViewStyle(.stack)
        }
        .background(ODSColor.primaryBackground.color)
    }
    
}

#if DEBUG
struct GuidelinesListView_Previews: PreviewProvider {
    static var previews: some View {
        GuidelinesList()
    }
}
#endif
