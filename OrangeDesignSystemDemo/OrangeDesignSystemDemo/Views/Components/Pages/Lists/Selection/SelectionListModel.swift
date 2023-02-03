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

class SelectionListVariantModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showSubtitle: Bool {
        didSet { updateItems() }
    }

    @Published var leadingIconOption: LeadingIconOption {
        didSet { updateItems() }
    }
        
    @Published var trailingOption: ODSListSelectionItemModel.TrailingSelection {
        didSet { updateItems() }
    }

    @Published var itemModels: [ODSListSelectionItemModel] = []
    private var recipes: [SelectedRecipe] = []
    typealias SelectedRecipe = (recipe: Recipe, selected: Bool)
    
    // ==================
    // MARK: Initializers
    // ==================
    init() {
        self.recipes = RecipeBook.shared.recipes.map { (recipe: $0, selected: Bool.random()) }
                
        showSubtitle = true
        leadingIconOption = .circle
        trailingOption = .checkmark
        
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
        
        itemModels = recipes.map {
            item(from: $0)
        }
    }

    private func item(from selectedRecipe: SelectedRecipe) -> ODSListSelectionItemModel {
        let isSelected = selectedRecipe.selected
        let recipe = selectedRecipe.recipe
        
        return ODSListSelectionItemModel(title: recipe.title,
                                  subtitle: showSubtitle ? recipe.subtitle : nil,
                                  leadingIcon: leadingIcon(from: recipe),
                                  trailingSelection: self.trailingOption,
                                  isSelected: isSelected)
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
}
