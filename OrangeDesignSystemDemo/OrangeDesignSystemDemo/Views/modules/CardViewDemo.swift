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

    let listModel = ODSListCardViewModel(title: "Card collections",
                                         cards: [
                                             ODSCardModel(title: "List", image: "Cards") {
                                                 CardViewDemoList()
                                             },
                                             ODSCardModel(title: "Grid", image: "Cards_1") {
                                                 CardViewDemoGrid()
                                             },
                                         ])
    var body: some View {
        ODSListCardView().environmentObject(listModel)
    }
}

struct CardViewDemoGrid: View {
    let cards = (1 ... 10).map {
        ODSCardModel(title: "Card \($0)", image: "empty")
    }

    let columns = [
        GridItem(.adaptive(minimum: 150.0), alignment: .topLeading),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: ODSSpacing.m) {
                ForEach(cards, id: \.title) { item in
                    NavigationLink(destination: EmptyView()) {
                        ODSCardView(element: item)
                    }
                }
            }
            .padding(EdgeInsets(top: ODSSpacing.m, leading: ODSSpacing.m, bottom: ODSSpacing.m, trailing: ODSSpacing.m))
        }
        .navigationTitle("CardView - Grid")
        .navigationViewStyle(.stack)
        .background(ODSColor.primaryBackground.color)
    }
}

struct CardViewDemoList: View {
    let cards = (1 ... 5).map {
        ODSCardModel(title: "Card \($0)", image: "empty", subTitle: "SubTitle \($0)", description: "Description \($0)")
    }

    var body: some View {
        let model = ODSListCardViewModel(title: "CardView - List", cards: cards)
        ODSListCardView().environmentObject(model)
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
