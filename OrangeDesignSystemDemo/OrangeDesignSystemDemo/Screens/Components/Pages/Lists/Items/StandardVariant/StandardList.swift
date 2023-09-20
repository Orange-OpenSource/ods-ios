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

struct StandardListVariant: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    let model: StandardListVariantModel
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            StandardListVariantInner(model: model)
        } options: {
            StandardListVariantOptions(model: model)
        }
    }
}
    
private struct StandardListVariantInner: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: StandardListVariantModel
    @State private var multiSelection: Set<UUID>? = nil
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List /* (selection: $multiSelection) */ {
            
            if !model.sectionOptions.isEmpty {
                Section {
                    ForEach(model.itemModels.0, id: \.id) { itemModel in
                        item(from: itemModel)
                    }
                    .onMove(perform: model.moveSection0)
                    .onDelete(perform: model.deleteSection0)
                }
                header: {
                    self.header
                }
                footer: {
                    self.footer
                }
            }
            
            Section {
                ForEach(model.itemModels.1, id: \.id) { itemModel in
                    item(from: itemModel)
                }
                .onMove(perform: model.moveSection1)
                .onDelete(perform: model.deleteSection1)
            } header: {
                self.header
            } footer: {
                self.footer
            }
            
            if model.sectionOptions.contains(.showHeader) {
                Section("Native Title 1") {
                    ForEach(model.itemModels.0, id: \.subtitle) { itemModel in
                        item(from: itemModel)
                    }
                }
                
                Section("Native Title 2") {
                    ForEach(model.itemModels.0, id: \.subtitle) { itemModel in
                        item(from: itemModel)
                    }
                }
            }
        }
        .modifier(ListStyleModifier(style: model.listStyle))
        .environment(\.defaultMinListHeaderHeight, 0)
        .toolbar { EditButton() }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Information icon tapped! Bon appétit", isPresented: $model.showSheetOnIButtonClicked) {
            Button("close", role: .cancel) {}
        }
    }
    
    @ViewBuilder
    func item(from itemModel: ODSListStandardItemModel) -> some View {
        if model.showDetails {
            NavigationLink(itemModel) {
                Text("\(itemModel.title) is clicked")
                    .navigationTitle(itemModel.title)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(Visibility.visible)
            .padding(.horizontal, ODSSpacing.s)
        } else {
            ODSListStandardItem(model: itemModel)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(Visibility.visible)
                .padding(.horizontal, ODSSpacing.s)
        }
    }
    
    @ViewBuilder
    var header: some View {
        if model.sectionOptions.contains(.showHeader) {
            ODSListSectionHeader(title: "Header")
            //        ODSListSectionHeader(title: "Title", description: "Description with sevral lines accepted")
        }
    }
    
    @ViewBuilder
    var footer: some View {
        if model.sectionOptions.contains(.showFooter) {
            ODSListSectionFooter(title: "Footer")
//            ODSListSectionFooter(title: "FOOTER", description: "Description with sevral lines accepted")
        }
    }
}


struct ListStyleModifier: ViewModifier {
    
    let style: StandardListVariantModel.ODSListStyle?
    
    func body(content: Content) -> some View {
        switch style {
        case .none:
            content
        case .grouped:
            content.listStyle(.grouped)
        case .plain:
            content.listStyle(.plain)
        case .sidebar:
            content.listStyle(.sidebar)
        }
    }
}

