/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// ==================================
// MARK: - NavigationBar search model
// ==================================

class NavigationBarSearchModel: ObservableObject {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @Published var searchQuery: String
    private var listItems: [String]
        
    // ==================
    // MARK: Initializers
    // ==================
    
    init() {
        searchQuery = ""
        listItems = (1 ... 10).map { "Item #\($0)" }
    }
        
    var filteredListItems: [String] {
        if searchQuery.isEmpty {
            return listItems
        } else {
            return listItems.filter { $0.contains(searchQuery) }
        }
    }
}

struct SearchModifier: ViewModifier {

    // ======================
    // MARK: Store properties
    // ======================

    let showSearch: Bool
    @ObservedObject var model: NavigationBarSearchModel

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        if showSearch {
            content
                .searchable(text: $model.searchQuery,
                            placement: .navigationBarDrawer(displayMode: .always))
        } else {
            content
        }
    }
}

struct ListExample: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject var model: NavigationBarSearchModel
    
    // ======================
    // MARK: Body
    // ======================

    var body: some View {
        List {
            ForEach(model.filteredListItems, id: \.self) { item in
                ODSListItem(title: Text(item)).odsListItemStyle(showSeparator: true)
            }
        }
        .listStyle(.plain)
    }
}

struct ActionIconsModifier: ViewModifier {

    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject var model: NavigationBarVariantModel
    
    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if model.actionIconCount > 0 {
                        ForEach(model.availableActions.reversed(), id: \.id) { action in
                            switch action {
                            case .showThemeSelection:
                                ThemeSelectionButton()
                                
                            case .showAlert(let iconName, let actionText):
                                ActionButton(iconName: iconName, actionText: actionText)
                            }
                        }
                    }
                }
            }
    }
}

private struct ActionButton: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    @State private var showAlert = false
    @Environment(\.theme) private var theme
    let iconName: String
    let actionText: String
    
    // ===========
    // MARK: Body
    // ===========

    var body: some View {
        Button {
            showAlert = true
        } label: {
            Image(systemName: iconName)
        }
        .foregroundColor(theme.componentColors.navigationBarForeground)
        .alert(actionText, isPresented: $showAlert) {
            Button("shared.close", role: .cancel) {}
        }
    }
}

