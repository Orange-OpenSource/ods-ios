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

/// Used to describe the list of cards View.
public class ODSListOfCardsViewModel: ObservableObject {
    public let cards: [ODSCardModel]
    public let title: String

    public init(title: String, cards: [ODSCardModel]) {
        self.title = title
        self.cards = cards
    }
}

/// Diosplay a list of cards in a single column.
/// A card is clickable and a destination View is open in the native navigation.
/// 
public struct ODSListOfCards: View {

    let model: ODSListOfCardsViewModel

    let columns = [
        GridItem(.flexible(), alignment: .topLeading),
    ]

    public init(model: ODSListOfCardsViewModel) {
        self.model = model
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: ODSSpacing.m) {
                ForEach(model.cards, id: \.title) { card in
                    NavigationLink(destination: card.destination) {
                        ODSCardView(element: card)
                    }
                }
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.m)
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(model.title)
        .navigationViewStyle(.stack)
        .background(ODSColor.primaryBackground.color)
    }
}
