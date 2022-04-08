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

import SwiftUI

public class ODSListModel: ObservableObject {
    public let cards: [ODSCardModel]
    public let title: String

    public init(title: String, cards: [ODSCardModel]) {
        self.title = title
        self.cards = cards
    }
}

public struct ListCardView: View {
    @EnvironmentObject private var list: ODSListModel

    let columns = [
        GridItem(.flexible(), alignment: .topLeading),
    ]

    public init() {}

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(list.cards, id: \.title) { card in
                    NavigationLink(destination: card.destination) {
                        ODSCardView(element: card)
                    }
                }
                .padding([.trailing])
            }
        }
        .padding([.leading, .top])
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(list.title)
        .navigationViewStyle(.stack)
        .background(Color(uiColor: .systemGray5))
    }
}
