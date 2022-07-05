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
class ListPageModel: ObservableObject {

    @Published var listModel: ListModel

    let secondLineOfTextChips: [ODSChip]
    let trailingImageChips: [ODSChip]
    let leadingImageChips: [ODSChip]

    @Published var selectedSecondLineOfTextChip: ODSChip? {
        didSet { updateListModel() }
    }

    @Published var selectedLeadingImageChip: ODSChip? {
        didSet { updateListModel() }
    }

    @Published var selectedTrailingImageChip: ODSChip? {
        didSet { updateListModel() }
    }

    @Published var minHeight: ODSListItemMinHeight = .large

    let toogleState: Binding<Bool>
    let showSheetOnIButtonClicked: Binding<Bool>

    init(toogleState: Binding<Bool>,
         showSheetOnIButtonClicked: Binding<Bool>)
    {
        self.toogleState = toogleState
        self.showSheetOnIButtonClicked = showSheetOnIButtonClicked

        secondLineOfTextChips = [ODSChip(0, text: "Subtitle")]
        leadingImageChips = [ODSChip(0, text: "Image")]
        trailingImageChips = [ODSChip(0, text: "Button icon"), ODSChip(1, text: "Text")]

        selectedSecondLineOfTextChip = secondLineOfTextChips[0]
        selectedLeadingImageChip = leadingImageChips[0]
        selectedTrailingImageChip = trailingImageChips[1]

        listModel = ListModel(itemModels: [])

        let genericItemsModels: [ListModel.ItemModelType] = defaultListItems().map { .generic($0) }
        let toggleItemModel: ListModel.ItemModelType = .withToggle(tooggleItemModel(with: minHeight))
        let items = [toggleItemModel] + genericItemsModels

        listModel = ListModel(itemModels: items)
    }

    func defaultListItems() -> [ODSListItemModel] {
        return Array(repeating: genericItemModel(), count: 5)
    }

    func genericItemModel() -> ODSListItemModel {
        let subTitle = selectedSecondLineOfTextChip == nil ? nil : "Subtitle"

        let image = Image("ListIcon", bundle: Bundle.main)
        let leadingIconModel = selectedLeadingImageChip == nil ? nil : ODSListItemLeadingIconModel.withImage(image)

        var trailingIconModel: ODSListItemTrailingIconModel?
        switch selectedTrailingImageChip?.id {
        case 0: trailingIconModel = ODSListItemTrailingIconModel.infoButton(onClicked: onIButtonClicked)
        case 1: trailingIconModel = ODSListItemTrailingIconModel.text("Details")
        default: trailingIconModel = nil
        }

        return ODSListItemModel(title: "Title",
                                subtitle: subTitle,
                                leadingIconModel: leadingIconModel,
                                trailingIconModel: trailingIconModel,
                                minHeight: minHeight)
    }

    func tooggleItemModel(with minHeight: ODSListItemMinHeight) -> ODSListItemWithToggleModel {
        return ODSListItemWithToggleModel(title: "Title: cell with toggle", isOn: toogleState,  minHeight: minHeight)
    }

    func updateListModel() {
        let newItems: [ListModel.ItemModelType] = listModel.itemModels.map { item in
            switch item {
            case .withToggle:
                return .withToggle(tooggleItemModel(with: minHeight))
            case .generic:
                let newModel = genericItemModel()
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
struct ListPage: View {
    @State var toggleState: Bool = false
    @State var showSheet: Bool = false

    var body: some View {
        ListPageInner(toggleState: $toggleState, showSheet: $showSheet)
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

struct ListPageInner: View {

    @ObservedObject var listPageModel: ListPageModel

    init(toggleState: Binding<Bool>, showSheet: Binding<Bool>) {
        listPageModel = ListPageModel(toogleState: toggleState, showSheetOnIButtonClicked: showSheet)
    }

    var body: some View {
        ZStack {
            ListView(model: listPageModel.listModel)
            BottomSheet().environmentObject(listPageModel)
        }
    }
}
