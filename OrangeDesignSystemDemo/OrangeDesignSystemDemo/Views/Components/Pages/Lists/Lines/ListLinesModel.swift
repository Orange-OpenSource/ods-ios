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

enum LeadingIconOption: Int, CaseIterable {
    case none = 0
    case icon
    case circle
    case wide
    case square
    
    var description: String {
        switch self {
        case .none:
            return "None"
        case .icon:
            return "Icon"
        case .circle:
            return "Circle"
        case .wide:
            return "Wide"
        case .square:
            return "Square"
        }
    }
    
    var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

enum TrailingOption: Int, CaseIterable {
    case text = 0
    case infoButton
        
    var description: String {
        switch self {
        case .text:
            return "Text"
        case .infoButton:
            return "Info Button"
        }
    }
        
    var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
        
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

struct Receipe {
    let title: String
    let subtitle: String
    let url: URL
    let iconName: String
}

let defaultReceipes: [Receipe] = [
    Receipe(title: "Summer Salad",
            subtitle: "20min",
            url: URL(string: "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80")!,
            iconName: "iconsCommunicationRUIcRestaurant"),
    Receipe(title: "Brocoli Soup",
            subtitle: "12min",
            url: URL(string: "https://images.unsplash.com/photo-1594756202469-9ff9799b2e4e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80")!,
            iconName: "iconsCommunicationDIcCookingPot"),
    Receipe(title: "Fig Sponge Cake",
            subtitle: "1h20",
            url: URL(string: "https://images.unsplash.com/photo-1565661834013-d196ca46e14e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80")!,
            iconName: "iconsCommunicationDIcCafe"),
    Receipe(title: "Raspberry Cake",
            subtitle: "45min",
            url: URL(string: "https://images.unsplash.com/photo-1615735487485-e52b9af610c1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80")!,
            iconName: "iconsCommunicationDIIcIceCream"),
    Receipe(title: "Easy Noodles",
            subtitle: "17min",
            url: URL(string:"https://images.unsplash.com/photo-1481931098730-318b6f776db0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=780&q=80")!,
            iconName: "iconsCommunicationRUIcRestaurant"),
]

// =============
// MARK: Models
// =============
class ListLinesVariantModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showSecondLine: Bool {
        didSet { updateItems() }
    }

    @Published var leadingIconOption: LeadingIconOption {
        didSet { updateItems() }
    }
        
    @Published var trailingOption: TrailingOption? {
        didSet { updateItems() }
    }

    @Published var itemModels: [ODSListItemModel] = []
    
    @Published var minHeight: ODSListItemMinHeight = .large

    private var recipes: [Receipe] = []
    
    // ==================
    // MARK: Initializers
    // ==================
    init() {
        self.recipes = defaultReceipes
                
        showSecondLine = true
        leadingIconOption = .circle
        trailingOption = .text
        
        updateItems()
    }
    
    //======================
    // MARK: Edition actions
    // =====================
    func delete(at offsets: IndexSet) {
        recipes.remove(atOffsets: offsets)
        updateItems()
    }

    func move(from source: IndexSet, to destination: Int) {
        recipes.move(fromOffsets: source, toOffset: destination)
        updateItems()
    }
    
    // =====================
    // MARK: Private helpers
    // =====================
    private func updateItems() {
        itemModels = recipes.map { item(from: $0) }
    }

    private func item(from recipe: Receipe) -> ODSListItemModel {
        ODSListItemModel(title: recipe.title,
                         subtitle: showSecondLine ? recipe.subtitle : nil,
                         leadingIcon: leadingIcon(from: recipe),
                         trailingIconModel: trailingIconModel(),
                         minHeight: .medium)
    }
    
    private func leadingIcon(from recipe: Receipe) -> ODSListItemIcon? {
        let emptyImage = Image("ods_empty", bundle: Bundle.ods)
        switch leadingIconOption {
        case .none:
            return nil
        case .icon:
            return .icon(Image(recipe.iconName))
        case .circle:
            return .circularImage(source: .asyncImage(recipe.url, emptyImage))
        case .square:
            return .squareImage(source: .asyncImage(recipe.url, emptyImage))
        case .wide:
            return .wideImage(source: .asyncImage(recipe.url, emptyImage))
        }
    }
    
    private func trailingIconModel() -> ODSListItemTrailingIconModel? {
        switch trailingOption {
        case .infoButton:
            return .infoButton(onClicked: onIButtonClicked)
        case .text:
            return .text("Details")
        case .none:
            return nil
        }
    }
    
    
    // MARK: Manage Info button added in navigation bar
    @Published var showSheetOnIButtonClicked: Bool = false
    
    func onIButtonClicked() {
        showSheetOnIButtonClicked = true
    }
}

