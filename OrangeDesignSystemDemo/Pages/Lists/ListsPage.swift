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

// MARK: Lists Page Model
class ListsPageModel: ObservableObject {

    @Published var showSubtitle: Bool {
        didSet { updateListModel() }
    }

    @Published var showLeftIcon: Bool {
        didSet { updateListModel() }
    }

    @Published var showRightIcon: Bool {
        didSet { updateListModel() }
    }

    @Published var minHeight: ODSListItemMinHeight {
        didSet { updateListModel() }
    }

    @Published var listModel: ListModel

    let toogleState: Binding<Bool>
    let showSheetOnIButtonClicked: Binding<Bool>

    init(showSubtitle: Bool = false,
         showLeftIcon: Bool = false,
         showRightIcon: Bool = true,
         toogleState: Binding<Bool>,
         showSheetOnIButtonClicked: Binding<Bool>)
    {
        self.showSubtitle = showSubtitle
        self.showLeftIcon = showLeftIcon
        self.showRightIcon = showRightIcon
        self.toogleState = toogleState
        self.showSheetOnIButtonClicked = showSheetOnIButtonClicked

        minHeight = .medium

        listModel = ListModel(itemModels: [])

        let rightIcons: [ODSListItemRightIconModel] = [
            .text("Details"),
            .infoButton(onClicked: onIButtonClicked),
        ]

        let genericItemsModels: [ListModel.ItemModelType] = rightIcons.map { icon in
            .generic(genericItemModel(with: icon))
        }

        let toggleItemModel: ListModel.ItemModelType = .withToggle(tooggleItemModel(with: minHeight))

        let items = [toggleItemModel] + genericItemsModels

        listModel = ListModel(itemModels: items)
    }

    func genericItemModel(with rightIcon: ODSListItemRightIconModel?) -> ODSListItemModel {
        let title = "Title"
        let subTitle = showSubtitle ? "The subtitle" : nil
        let image = Image("ListIcon", bundle: Bundle.main)
        let leftIconModel = showLeftIcon ? ODSListItemLeftIconModel.withImage(image) : nil
        let rightIconModel = showRightIcon ? rightIcon : nil

        return ODSListItemModel(title: title,
                                subtitle: subTitle,
                                leftIconModel: leftIconModel,
                                rightIconModel: rightIconModel,
                                minHeight: minHeight)
    }

    func tooggleItemModel(with minHeight: ODSListItemMinHeight) -> ODSListItemWithToggleModel {
        return ODSListItemWithToggleModel(title: "Title: cell with toggle", minHeight: minHeight, isOn: toogleState)
    }

    func updateListModel() {
        let newItems: [ListModel.ItemModelType] = listModel.itemModels.map { item in
            switch item {
            case .withToggle:
                return .withToggle(tooggleItemModel(with: minHeight))
            case let .generic(model):
                let newModel = genericItemModel(with: model.rightIconModel)
                return .generic(newModel)
            }
        }

        listModel.itemModels = newItems
    }

    func onIButtonClicked() {
        showSheetOnIButtonClicked.wrappedValue = true
    }
}

// MARK: Lists Page Views
struct ListsPage: View {
    @State var toggleState: Bool = false
    @State var showSheet: Bool = false

    var body: some View {
        ListsPageInner(toggleState: $toggleState, showSheet: $showSheet)
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    ScrollView {
                        HStack {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("This is a view presented when \"i\" button is clicked")
                                Text("The toggle in item is \(toggleState ? "ON" : "OFF")")
                            }

                            Spacer()
                        }
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                    }
                    .navigationTitle("Info")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationViewStyle(.stack)
                }
            }
    }
}

struct ListsPageInner: View {

    @ObservedObject var listsPageModel: ListsPageModel

    init(toggleState: Binding<Bool>, showSheet: Binding<Bool>) {
        listsPageModel = ListsPageModel(toogleState: toggleState, showSheetOnIButtonClicked: showSheet)
    }

    var body: some View {
        ZStack {
            ListView(model: listsPageModel.listModel)
            BottomSheet().environmentObject(listsPageModel)
        }
    }
}
