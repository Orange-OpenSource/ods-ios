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

public struct ODSCardImageFirstListItemModel: Identifiable {
    let cardModel: ODSCardImageFirstModel
    let destination: AnyView?

    public init<Destination>(cardModel: ODSCardImageFirstModel, @ViewBuilder destination: () -> Destination) where Destination: View {
        self.cardModel = cardModel
        self.destination = AnyView(destination())
    }

    public init(cardModel: ODSCardImageFirstModel) {
        self.cardModel = cardModel
        destination = AnyView(Text(cardModel.title + " to be define"))
    }

    public var id: String {
        cardModel.title
    }
}

public struct ODSCardImageFirstListModel: Identifiable {

    let title: String
    let items: [ODSCardImageFirstListItemModel]

    public var id: String {
        title
    }

    public init(title: String, items: [ODSCardImageFirstListItemModel]) {
        self.title = title
        self.items = items
    }
}

public struct ODSCardImageFirstList: View {

    let model: ODSCardImageFirstListModel
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: ODSSpacing.xs, alignment: .topLeading),
    ]

    public init(model: ODSCardImageFirstListModel) {
        self.model = model
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                    ForEach(model.items) { item in
                        ODSCardImageFirst(model: item.cardModel) {
                            Image("lkl")
                        }
                    }
                }
                .padding(EdgeInsets(top: ODSSpacing.m, leading: ODSSpacing.m, bottom: ODSSpacing.m, trailing: ODSSpacing.m))
            }
            .navigationTitle(model.title)
            .navigationViewStyle(.stack)
        }
        .background(ODSColor.primaryBackground.color)
    }
}

struct ODSCardImageFirstListItem: View {

    let model: ODSCardImageFirstListItemModel

    var body: some View {
        NavigationLink {
            model.destination
                .navigationTitle(model.cardModel.title)
                .navigationViewStyle(.stack)
                .background(Color(uiColor: .systemGray6))
        } label: {
            ODSCardImageFirst(model: model.cardModel)
        }
    }
}

#if DEBUG
struct ODSCardImageFirstList_Previews: PreviewProvider {

    static let cards: [ODSCardImageFirstListItemModel] = (1 ... 10).map {
        let title = "Card \($0)"
        let model = ODSCardImageFirstModel(title: title, subtitle: "Subtitle",
                                           image: Image("ods_empty", bundle: Bundle.ods))

        return ODSCardImageFirstListItemModel(cardModel: model) {
            Text("This is the \(title) destination view")
        }
    }

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ODSCardImageFirstList(model: ODSCardImageFirstListModel(title: "List of Image First cards", items: cards))
                .preferredColorScheme($0)
        }
    }
}
#endif
