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

struct CardViewDemo: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject private var themeProvider: ThemeProvider

    // =====================
    // MARK: Computed values
    // =====================

    private func imageFrom(resourceName: String) -> Image {
        themeProvider.imageFromResources(resourceName)
    }

    private var items: [ODSListOfCardImageFirstItemModel] {
        [
            ODSListOfCardImageFirstItemModel(cardModel: ODSCardImageFirstModel(title: "List", imageSource: .image(imageFrom(resourceName: "Cards")))) {
                CardViewDemoList()
            },
            ODSListOfCardImageFirstItemModel(cardModel: ODSCardImageFirstModel(title: "Grid", imageSource: .image(imageFrom(resourceName: "Cards_1")))) {
                CardViewDemoGrid()
            },
        ]
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ODSListOfCardImageFirst(title: "Card collections", itemModels: items)
            .navigationbarMenuForThemeSelection()
    }
}

struct CardViewDemoGrid: View {
    let cardsModelsOLD = (1 ... 10).map {
        ODSSmallCardModel(title: "Card \($0)",
                          imageSource: .image(Image("empty", bundle: Bundle.main)))
    }

    let cardsModels = RecipeBook.shared.recipes.map { recipe in
            return ODSSmallCardModel(title: recipe.title,
                              imageSource: .asyncImage(recipe.url, Image("empty", bundle: Bundle.main))
                              )}

    var body: some View {
        ScrollView {
            ODSGridOfCards(cardModels: cardsModels)
                .padding(.all, ODSSpacing.m)
        }
        .navigationTitle("Grid")
        .navigationViewStyle(.stack)
        .navigationbarMenuForThemeSelection()
    }
}

struct CardViewDemoList: View {
    let itemModels: [ODSListOfCardImageFirstItemModel] =
    RecipeBook.shared.recipes.map { recipe in
        let cardModel = ODSCardImageFirstModel(title: recipe.title,
                                               subtitle: recipe.subtitle,
                                               imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                                               supportingText: recipe.description)
        
        return ODSListOfCardImageFirstItemModel(cardModel: cardModel)
    }
    
    let itemModelsOld: [ODSListOfCardImageFirstItemModel] = (1 ... 5).map {
        let cardModel = ODSCardImageFirstModel(title: "Card \($0)", subtitle: "SubTitle \($0)", imageSource: .image(Image("empty")), supportingText: "Description \($0)")
        return ODSListOfCardImageFirstItemModel(cardModel: cardModel)
    }

    var body: some View {
        ODSListOfCardImageFirst(title: "List", itemModels: itemModels)
            .navigationbarMenuForThemeSelection()
    }
}

#if DEBUG
struct CardViewDemoGrid_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemoGrid()
            .previewInterfaceOrientation(.portrait)

        CardViewDemoGrid()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3) // <- CONSTANT
    }
}

struct CardViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemo()
            .previewInterfaceOrientation(.portrait)
    }
}

struct CardViewDemoList_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemoList()
            .previewInterfaceOrientation(.portrait)
        CardViewDemoList()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3) // <- CONSTANT
    }
}

#endif
