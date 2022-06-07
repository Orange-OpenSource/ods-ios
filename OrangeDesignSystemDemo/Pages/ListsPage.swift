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

let heart = Image(systemName: "heart.fill")

struct ListsPage: View {

    @State var toogleAcivated: Bool = false

    var body: some View {
        ZStack {
            ODSList(model: ODSListModel(itemModels: [ODSListItemModel(title: "Title"),
                                                     ODSListItemModel(title: "Title", rightIconModel: .chevron(nil)),
                                                     ODSListItemModel(title: "Title", rightIconModel: .chevron("With text")),
                                                     ODSListItemModel(title: "Title", rightIconModel: .text("Detail")),
                                                     ODSListItemModel(title: "Title", rightIconModel: .toggle($toogleAcivated)),
                                                     ODSListItemModel(title: "Title", leftIconModel: .withImage(heart))]))
            BottomSheet()
        }
        /*

         ScrollView {
             ListItemsView(title: "One line", models: [ODSListItemModel(title: "Title"),
                                                       ODSListItemModel(title: "Title", rightIconModel: .chevron),
                                                       ODSListItemModel(title: "Title", rightIconModel: .text("Detail")),
                                                       ODSListItemModel(title: "Title", rightIconModel: .toggle($toogleAcivated)),
                                                       ODSListItemModel(title: "Title", leftIconModel: .withImage(heart))])
             ListItemsView(title: "Two lines", models:
                             [ODSListItemModel(title: "Title", subtitle: "Subtile with long text"),
                              ODSListItemModel(title: "Title", subtitle: "Subtile with long text", rightIconModel: .chevron),
                              ODSListItemModel(title: "Title", subtitle: "Subtile with long text", rightIconModel: .text("Detail")),
                              ODSListItemModel(title: "Title", subtitle: "Subtile with long text", rightIconModel: .toggle($toogleAcivated)),
                              ODSListItemModel(title: "Title", subtitle: "Subtile with long text", leftIconModel: .withImage(heart), rightIconModel: .toggle($toogleAcivated))])
         }
          */
    }
}

struct ListItemsView: View {

    let title: String
    let models: [ODSListItemModel]

    var body: some View {
        VStack {
            Text(title)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .background(Color(UIColor.systemGray5))

            ForEach(models, id: \.id) { model in
                ODSListItem(model: model)
                Divider()
            }
        }
    }
}

struct BottomSheedHeader: View {

    @Binding var showContent: Bool

    var body: some View {
        VStack {
            Spacer()

            Button {
                showContent.toggle()
            } label: {
                VStack {
                    Divider()

                    HStack(spacing: 16) {
                        let imageName = showContent ? "chevron.down" : "chevron.up"

                        Image(systemName: imageName)
                            .foregroundColor(.primary)
                            .accessibility(hidden: true)

                        Text("Swipe down to view")
                            .font(.body)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.all, 16)

                    Divider()
                }
            }
            .frame(height: 32)
        }
    }
}

enum Choice: Identifiable {
    case oneLine
    case twoLines
    case treeLines

    var id: Self { self }

    var label: String {
        switch self {
        case .oneLine:
            return "1 line"
        case .twoLines:
            return "2 lines"
        case .treeLines:
            return "3 lines"
        }
    }
}

struct BottomSheetContent: View {

    @State var selection: Choice = .oneLine

    var body: some View {
        Picker("List size", selection: $selection) {
            Text(Choice.oneLine.label).tag(Choice.oneLine)
            Text(Choice.twoLines.label).tag(Choice.twoLines)
            Text(Choice.treeLines.label).tag(Choice.treeLines)
        }
        .pickerStyle(.segmented)

        Text(selection.label)
    }
}

struct BottomSheet: View {
    @State var showContent: Bool = false

    var body: some View {
        VStack {
            BottomSheedHeader(showContent: $showContent)
            if showContent {
                BottomSheetContent()
            }
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        ListsPage()
    }
}
