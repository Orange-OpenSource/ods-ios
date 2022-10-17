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

struct ListLinesVariant: View {
    let model: ListLinesVariantModel
    
    var body: some View {
        ZStack {
            ListLinesVariantInner(model: model)
            BottomSheet {
                ListLinesBottomSheet()
            }
            .environmentObject(model)
        }
        .background(ODSColor.componentBackground2.color)
    }
    
    init() {
        model = ListLinesVariantModel()
    }
}
    
struct ListLinesVariantInner: View {
    @ObservedObject var model: ListLinesVariantModel
    @State var multiSelection: Set<UUID>?

    init(model: ListLinesVariantModel) {
        self.model = model
    }

    var body: some View {
        List /* (selection: $multiSelection) */ {
            ForEach(model.itemModels, id: \.id) { itemModel in
                
                NavigationLink {
                    Text("\(itemModel.title) is clicked")
                        .navigationTitle(itemModel.title)
                } label: {
                    ODSListItem(model: itemModel)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(Visibility.visible)
            }
            .onMove(perform: move)
            .onDelete(perform: delete)
            .padding(.horizontal, ODSSpacing.m)
        }
        .toolbar { EditButton() }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $model.showSheetOnIButtonClicked) {
            ListInfoFromButtonI()
        }
    }

    func delete(at offsets: IndexSet) {
        model.delete(at: offsets)
    }

    func move(from source: IndexSet, to destination: Int) {
        model.move(from: source, to: destination)
    }
}

struct ListInfoFromButtonI: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    VStack(alignment: .leading, spacing: ODSSpacing.l) {
                        Text("This is a view presented when \"i\" button is clicked")
                    }

                    Spacer()
                }
                .padding(.top, ODSSpacing.none)
                .padding(.bottom, ODSSpacing.xs)
                .padding(.horizontal, ODSSpacing.m)
            }
            .navigationTitle("Info")
            .navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)
        }
    }
}

