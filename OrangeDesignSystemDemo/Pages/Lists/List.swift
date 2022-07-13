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

// =============
// MARK: Models
// =============
class ListModel: ObservableObject {
    public enum ItemModelType: Identifiable {
        case generic(ODSListItemModel)
        case withToggle(ODSListItemWithToggleModel)

        var id: UUID {
            switch self {
            case let .generic(model):
                return model.id
            case let .withToggle(model):
                return model.id
            }
        }
    }

    @Published var itemModels: [ItemModelType]

    init(itemModels: [ItemModelType]) {
        self.itemModels = itemModels
    }

    func delete(at offsets: IndexSet) {
        itemModels.remove(atOffsets: offsets)
    }

    func move(from source: IndexSet, to destination: Int) {
        itemModels.move(fromOffsets: source, toOffset: destination)
    }
}

// ============
// MARK: Views
// ============
struct ListView: View {
    @ObservedObject var model: ListModel
    @State var multiSelection: Set<UUID>?

    var body: some View {
        List /* (selection: $multiSelection) */ {
            ForEach(model.itemModels, id: \.id) { itemModelType in
                
                switch itemModelType {
                case let .generic(model):
                    NavigationLink(model) {
                        Text("\(model.title) is clicked")
                    }
                    .listRowInsets(EdgeInsets())

                case let .withToggle(model):
                    ODSListItemWithToggle(model: model)
                }
            }
            .onMove(perform: move)
            .onDelete(perform: delete)
            .listRowSeparator(Visibility.visible)
            .padding(.horizontal, 16)
        }
        .toolbar { EditButton() }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }

    func delete(at offsets: IndexSet) {
        model.delete(at: offsets)
    }

    func move(from source: IndexSet, to destination: Int) {
        model.move(from: source, to: destination)
    }

    init(model: ListModel) {
        self.model = model
    }
}
