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

struct NavigationBarComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Bars - navigation"
        image = Image("Navigation bars")
        description = "A navigation bar appears at the top of an app screen, below the status bar, and enables navigation through a series of hierarchical screens."
        
        variants = AnyView(NavigationBarVariants())
    }
}

struct NavigationBarVariants: View {

    var body: some View {
        VariantEntryItem(text: "Bar nav - demo", technicalElement: "NavigationView") {
            NavigationBarVariant(model: NavigationBarBottomSheetModel())
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

struct ActionIconsModifier: ViewModifier {

    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject var model: NavigationBarBottomSheetModel
    
    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if model.actionIconCount > 0 {
                        ForEach(model.availableActions, id: \.iconName) { action in
                            ActionButton(action: action)
                        }
                    }
                }
            }
    }
}

struct ActionButton: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    @State private var showAction = false
    let action: NavigationBarBottomSheetModel.Action
    
    // ===========
    // MARK: Body
    // ===========

    var body: some View {
        ODSIconButton(image: Image(systemName:action.iconName)) {
            showAction = true
        }
        .alert(action.actionText, isPresented: $showAction) {
            Button("close", role: .cancel) {}
        }
    }
}

struct NavigationBarVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: NavigationBarBottomSheetModel

    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        ZStack {
            navigationContent()
            BottomSheet {
                NavigationBarVariantBottomSheet()
            }
            .environmentObject(model)
        }
    }
    
    // =====================
    // MARK: Private helpers
    // =====================

    @ViewBuilder
    private func navigationContent() -> some View {
        let searchModel = NavigationBarSearchModel()
        
        ListExample(model: searchModel)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(model.titleSize.displayMode)
            .modifier(SearchModifier(showSearch: model.showSearch, model: searchModel))
            .modifier(ActionIconsModifier(model: model))
            .navigationBarBackButtonHidden(!model.showBackButton)
    }
    
    private var title: String {
        switch model.titleSize {
        case .standard:
            return "Title"
        case.large:
            return "Large Title"
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
                ODSListItem(model: ODSListItemModel(title: item))
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(Visibility.visible)
            .padding(.horizontal, ODSSpacing.m)
        }
        .listStyle(.plain)
    }
}

#if DEBUG
struct NavigationBarPage_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    NavigationBarVariants()
                }
            }
        }
    }
}
#endif
