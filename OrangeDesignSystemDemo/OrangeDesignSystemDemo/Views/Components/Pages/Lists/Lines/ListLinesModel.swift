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
class ListLinesVariantModel: ObservableObject {

    // MARK: Bottom sheet options
    @Published var showSecondLine: Bool {
        didSet { updateItems() }
    }

    @Published var showLeadingImage: Bool {
        didSet { updateItems() }
    }
    
    enum TrailingImageChip {
        case text
        case infoButton
    }
    let trailingImageChips: [ODSChip<TrailingImageChip>]
    @Published var selectedTrailingImageChip: TrailingImageChip? {
        didSet { updateItems() }
    }

    @Published var minHeight: ODSListItemMinHeight = .large
    
    // MARK: Item models
    @Published var itemModels: [ODSListItemModel] = []

    init() {
        let items = [
            ODSListItemModel(title: "Title 1",
                             subtitle: "SubTitle",
                             leadingIconModel: nil,
                             trailingIconModel: nil,
                             minHeight: .medium),
            ODSListItemModel(title: "Title 2",
                             subtitle: "SubTitle",
                             leadingIconModel: nil,
                             trailingIconModel: nil,
                             minHeight: .large)
        ]

        self.itemModels = items
        
        showSecondLine = true
        showLeadingImage = true
        trailingImageChips = [ODSChip(.infoButton, text: "Button icon"), ODSChip(.text, text: "Text")]
        selectedTrailingImageChip = .text
        
        updateItems()

    }
    
    // MARK: List edition actions
    func delete(at offsets: IndexSet) {
        itemModels.remove(atOffsets: offsets)
    }

    func move(from source: IndexSet, to destination: Int) {
        itemModels.move(fromOffsets: source, toOffset: destination)
    }
    
    // MARK: List items
    func update(item: ODSListItemModel) -> ODSListItemModel {
        let subTitle = showSecondLine ? "Subtitle" : nil

        let image = Image("ListIcon", bundle: Bundle.main)
        let leadingIconModel = showLeadingImage ? ODSListItemLeadingIconModel.withImage(image) : nil

        var trailingIconModel: ODSListItemTrailingIconModel?
        switch selectedTrailingImageChip {
        case .infoButton:
            trailingIconModel = ODSListItemTrailingIconModel.infoButton(onClicked: onIButtonClicked)
        case .text:
            trailingIconModel = ODSListItemTrailingIconModel.text("Details")
        default:
            trailingIconModel = nil
        }

        return ODSListItemModel(title: item.title,
                                subtitle: subTitle,
                                leadingIconModel: leadingIconModel,
                                trailingIconModel: trailingIconModel,
                                minHeight: minHeight)
    }
    
    func updateItems() {
        itemModels = itemModels.map { update(item: $0) }
    }
    
    // MARK: Manage Info button added in navigation bar
    @Published var showSheetOnIButtonClicked: Bool = false
    
    func onIButtonClicked() {
        showSheetOnIButtonClicked = true
    }
}

