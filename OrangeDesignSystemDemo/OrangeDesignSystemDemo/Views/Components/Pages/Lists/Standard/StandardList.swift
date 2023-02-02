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
        ZStack {
            StandardListVariantInner(model: model)
            BottomSheet {
                StandardListBottomSheet()
            }
            .environmentObject(model)
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
            ForEach(model.itemModels, id: \.id) { itemModel in
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
            .onMove(perform: model.move)
            .onDelete(perform: model.delete)
        }
        .toolbar { EditButton() }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .alert("Information icon tapped! Bon appétit", isPresented: $model.showSheetOnIButtonClicked) {
            Button("close", role: .cancel) {}
        }
    }
}
