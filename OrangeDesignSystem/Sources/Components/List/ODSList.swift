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

// =============
// MARK: Models
// =============
public struct ODSListModel {
    let itemModels: [ODSListItemModel]

    public init(itemModels: [ODSListItemModel]) {
        self.itemModels = itemModels
    }
}

// ============
// MARK: Views
// ============
public struct ODSList: View {
    let model: ODSListModel
    @State var selection: UUID?

    public var body: some View {
        ScrollView {
            ForEach(model.itemModels, id: \.id) { model in
                switch model.rightIconModel {
                case .toggle, .none:
                    ODSListItem(model: model)
                case let .text(text) where text.isEmpty:
                    ODSListItem(model: model)
                default:
                    NavigationLink {
                        Text("\(model.title) is clicked")
                    } label: {
                        ODSListItem(model: model)
                    }
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }

    public init(model: ODSListModel) {
        self.model = model
    }
}
