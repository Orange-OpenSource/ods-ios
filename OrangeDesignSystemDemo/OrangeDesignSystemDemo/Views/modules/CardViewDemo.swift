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

struct CardViewDemo: View {

    let items = [
        ODSListOfCardImageFirstItemModel(cardModel: ODSCardImageFirstModel(title: "List", image: Image("Cards"))) {
            CardViewDemoList()
        },
        ODSListOfCardImageFirstItemModel(cardModel: ODSCardImageFirstModel(title: "Grid", image: Image("Cards_1"))) {
            CardViewDemoGrid()
        },
    ]

    var body: some View {
        return ODSListOfCardImageFirst(title: "Card collections", itemModels: items)
    }
}

struct CardViewDemoGrid: View {
    let cardsModels = (1 ... 10).map {
        ODSSmallCardModel(title: "Card \($0)", image: Image("empty", bundle: Bundle.main))
    }

    var body: some View {
        ScrollView {
            ODSGridOfCards(cardModels: cardsModels)
                .padding(.all, ODSSpacing.m)
        }
        .navigationTitle("Grid")
        .navigationViewStyle(.stack)
        .background(ODSColor.primaryBackground.color)
    }
}

struct CardViewDemoList: View {
    let itemModels: [ODSListOfCardImageFirstItemModel] = (1 ... 5).map {
        let cardModel = ODSCardImageFirstModel(title: "Card \($0)", subtitle: "SubTitle \($0)", image: Image("empty"), supportingText: "Description \($0)")
        return ODSListOfCardImageFirstItemModel(cardModel: cardModel)
    }

    var body: some View {
        ODSListOfCardImageFirst(title: "List", itemModels: itemModels)
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
