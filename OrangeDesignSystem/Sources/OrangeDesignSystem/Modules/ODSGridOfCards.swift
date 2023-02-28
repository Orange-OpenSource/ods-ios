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

/// Used to display in a grid of cards.
/// A destination view is added to the card
/// which it is displayed when card is clicked.
///
public struct ODSGridOfCards: View {

    public let cardModels: [ODSCardSmallModel]

    let columns = [
        GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .topLeading),
    ]

    public init(cardModels: [ODSCardSmallModel]) {
        self.cardModels = cardModels
    }

    public var body: some View {
        LazyVGrid(columns: columns, spacing: ODSSpacing.none) {
            ForEach(cardModels) { cardModel in
                if let destination = cardModel.destination {
                    NavigationLink(destination: destination) {
                        ODSCardSmall(model: cardModel)
                    }
                } else {
                    ODSCardSmall(model: cardModel)
                }
            }
        }
        .padding(.bottom, ODSSpacing.m)
    }
}

#if DEBUG
struct ODSGridOfCards_Previews: PreviewProvider {

    static let columns = [
        GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .topLeading),
    ]

    static let cardsModels = [
        ODSCardSmallModel(title: "1 Title", imageSource: .image(Image("ods_empty", bundle: Bundle.ods))) {
            Text("This card has a destination view")
        },
        ODSCardSmallModel(title: "2 Title", subtitle: "2 Subtitle", imageSource: .image(Image("ods_empty", bundle: Bundle.ods))),
        ODSCardSmallModel(title: "3 A long long title", subtitle: "3 A long long Subtitle", imageSource: .image(Image("ods_empty", bundle: Bundle.ods))),
        ODSCardSmallModel(title: "4 A long long Title", imageSource: .image(Image("ods_empty", bundle: Bundle.ods))),
    ]

    struct TestVeiw: View {
        var body: some View {
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: ODSSpacing.none) {

                        Text("Card in Vertical grid")
                            .odsFont(.title1)
                            .frame(width: .infinity, alignment: .leading)
                            .padding(.bottom, ODSSpacing.m)

                        ODSGridOfCards(cardModels: ODSGridOfCards_Previews.cardsModels)

                        Text("Card in content view")
                            .odsFont(.title1)
                            .frame(width: .infinity, alignment: .leading)
                            .padding(.bottom, ODSSpacing.m)

                        ODSCardSmall(model: ODSCardSmallModel(title: "Title 4", subtitle: "Subtitle 4", imageSource: .image(Image("ods_empty", bundle: Bundle.ods))))
                    }
                    .padding(.horizontal, ODSSpacing.m)
                }
            }
        }
    }

    static var previews: some View {
        TestVeiw()
    }
}
#endif
