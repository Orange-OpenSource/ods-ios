//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
            return °°"shared.none"
        case .icon:
            return °°"shared.icon"
        case .circle:
            return °°"shared.circle"
        case .wide:
            return °°"shared.wide"
        case .square:
            return °°"shared.square"
        }
    }

    var chip: ODSChip<Self> {
        ODSChip(self, text: description)
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
            return °°"shared.text"
        case .infoButton:
            return °°"screens.components.lists.options.description.info_button"
        }
    }

    var chip: ODSChip<Self> {
        ODSChip(self, text: description)
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

    @Published var showSubtitle: Bool {
        didSet { updateItems() }
    }

    @Published var leadingIconOption: LeadingIconOption {
        didSet { updateItems() }
    }

    @Published var trailingOptions: [TrailingOption] {
        didSet { updateItems() }
    }

    @Published var itemModels: [ODSListStandardItemModel] = []

    @Published var showDetails: Bool

    private var recipes: [Recipe] = []

    // ==================
    // MARK: Initializers
    // ==================

    init() {
        recipes = RecipeBook.shared.recipes

        showSubtitle = true
        leadingIconOption = .circle
        trailingOptions = [.text, .infoButton]
        showDetails = true

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
            return ODSListItemTrailingActions(displayText: °°"screens.components.list.details", onIButtonClicked: onIButtonClicked)
        case (true, false):
            return ODSListItemTrailingActions(displayText: °°"screens.components.list.details")
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
