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
// MARK: Options
// =============

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

// ==============
// MARK: - Models
// ==============

class StandardListVariantModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var sectionOptions: [SectionListOption] {
        didSet { updateItems() }
    }
    
    enum ODSListStyle: Int, CaseIterable {
        case grouped
        case plain
        case sidebar
        
        var description: String {
            switch self {
            case .grouped:
                return "Grouped"
            case .plain:
                return "Plain"
            case .sidebar:
                return "Sidebar"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
        
        var swiftStyle: (any ListStyle) {
            switch self {
            case .grouped:
                return GroupedListStyle()
            case .plain:
                return PlainListStyle()
            case .sidebar:
                return SidebarListStyle()
            }
            
        }
    }
    
    @Published var listStyle: ODSListStyle?

    @Published var showSubtitle: Bool {
        didSet { updateItems() }
    }

    @Published var leadingIconOption: LeadingIconOption {
        didSet { updateItems() }
    }
        
    @Published var trailingOptions: [TrailingOption] {
        didSet { updateItems() }
    }

    @Published var itemModels: ([ODSListStandardItemModel], [ODSListStandardItemModel]) = ([],[])
    
    @Published var showDetails: Bool
    
    private var recipes: ([Recipe],[Recipe]) = ([],[])
    
    // ==================
    // MARK: Initializers
    // ==================
    
    init() {
        self.recipes = ([], RecipeBook.shared.recipes)
                
        sectionOptions = []
        showSubtitle = true
        leadingIconOption = .circle
        trailingOptions = [.text, .infoButton]
        showDetails = true
        
        updateItems()
    }
    
    //======================
    // MARK: Edition actions
    // =====================
    
    func deleteSection0(at offsets: IndexSet) {
        recipes.0.remove(atOffsets: offsets)
        updateItems()
    }

    func moveSection0(from source: IndexSet, to destination: Int) {
        recipes.0.move(fromOffsets: source, toOffset: destination)
        updateItems()
    }

    func deleteSection1(at offsets: IndexSet) {
        recipes.1.remove(atOffsets: offsets)
        updateItems()
    }

    func moveSection1(from source: IndexSet, to destination: Int) {
        recipes.1.move(fromOffsets: source, toOffset: destination)
        updateItems()
    }

    // =====================
    // MARK: Private helpers
    // =====================
    
    private func updateItems() {
        let splitIndex = sectionOptions.isEmpty ? 0 : 4
        let recipes = (Array(RecipeBook.shared.recipes.prefix(splitIndex)), Array(RecipeBook.shared.recipes.suffix(from: splitIndex)))
        itemModels = (recipes.0.map { item(from: $0) }, recipes.1.map { item(from: $0) })
    }

    private func item(from recipe: Recipe) -> ODSListStandardItemModel {
        return ODSListStandardItemModel(title: recipe.title,
                                        subtitle: showSubtitle ? recipe.subtitle : nil,
                                        leadingIcon: leadingIcon(from: recipe),
                                        trailingActions: trailingActions)
    }
    
    private func leadingIcon(from recipe: Recipe) -> ODSListItemLeadingIcon? {
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
    
    private var trailingActions: ODSListItemTrailingActions? {

        let showText = trailingOptions.contains { $0 == .text }
        let showIButton = trailingOptions.contains { $0 == .infoButton }
        
        switch (showText, showIButton) {
        case (true, true):
            return ODSListItemTrailingActions(displayText: "Details", onIButtonClicked: onIButtonClicked)
        case (true, false):
            return ODSListItemTrailingActions(displayText: "Details")
        case (false, true):
            return ODSListItemTrailingActions(onIButtonClicked: onIButtonClicked)
        default:
            return nil
        }
    }
    
    
    // =====================
    // MARK: Buttons actions
    // =====================

    // Add button in navigation bar action
    @Published var showSheetOnIButtonClicked: Bool = false
    
    // Info button action
    func onIButtonClicked() {
        showSheetOnIButtonClicked = true
    }
}
