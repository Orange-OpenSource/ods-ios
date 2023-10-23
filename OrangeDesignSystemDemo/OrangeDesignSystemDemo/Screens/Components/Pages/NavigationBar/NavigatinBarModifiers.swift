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

// MARK: NavigationBar search model
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
            Button("close", role: .cancel) {}
        }
    }
}

