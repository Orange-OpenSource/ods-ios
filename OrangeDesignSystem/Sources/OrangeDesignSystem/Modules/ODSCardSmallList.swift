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

public struct ODSCardSmallListItemModel: Identifiable {
    let title: String
    let subtitle: String?
    let image: Image
    let destination: AnyView?

    public init<Destination>(title: String, subtitle: String? = nil, image: Image, @ViewBuilder destination: () -> Destination) where Destination: View {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.destination = AnyView(destination())
    }

    public init(title: String, subtitle: String? = nil, image: Image) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        destination = AnyView(Text(title + " to be define"))
    }

    public var id: String {
        title
    }
}

public struct ODSCardSmallListModel: Identifiable {

    let title: String
    let items: [ODSCardSmallListItemModel]

    public var id: String {
        title
    }

    public init(title: String, items: [ODSCardSmallListItemModel]) {
        self.title = title
        self.items = items
    }
}

public struct ODSCardSmallList: View {

    let model: ODSCardSmallListModel
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: ODSSpacing.xs, alignment: .topLeading),
    ]

    public init(model: ODSCardSmallListModel) {
        self.model = model
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                    ForEach(model.items) { item in
                        ODSCardSmallListItem(model: item)
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

struct ODSCardSmallListItem: View {

    let model: ODSCardSmallListItemModel

    var body: some View {
        NavigationLink {
            model.destination
                .navigationTitle(model.title)
                .navigationViewStyle(.stack)
                .background(Color(uiColor: .systemGray6))
        } label: {
            ODSCardSmall(title: model.title, subtitle: model.subtitle, image: model.image)
        }
    }
}

#if DEBUG
struct ODSCardSmallList_Previews: PreviewProvider {

    static let cards: [ODSCardSmallListItemModel] = (1 ... 10).map {
        let title = "Card \($0)"
        return ODSCardSmallListItemModel(title: title, image: Image("ods_empty", bundle: Bundle.ods)) {
            Text("This is the \(title) destination view")
        }
    }

    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ODSCardSmallList(model: ODSCardSmallListModel(title: "List of small cards", items: cards))
                .preferredColorScheme($0)
        }
    }
}
#endif
