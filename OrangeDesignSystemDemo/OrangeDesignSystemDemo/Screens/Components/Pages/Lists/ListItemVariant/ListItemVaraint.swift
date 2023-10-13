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

struct ListItemVariant: View {
    
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    let model: ListItemVariantModel
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        CustomizableVariant {
            ListItemVariantInner(model: model)
        } options: {
            ListItemVariantOptions(model: model)
        }
    }
}

private struct ListItemVariantInner: View {
    
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    @ObservedObject var model: ListItemVariantModel
    private let recipe: Recipe
    
    @State private var isSelected: Bool = true
    @State private var showAlert: Bool = false

    init(model: ListItemVariantModel) {
        self.model = model
        self.recipe = RecipeBook.shared.recipes[0]
    }

    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        List {
            if model.navigate {
                NavigationLink {
                    Text("Bon appetit!")
                } label: {
                    listItem
                }
            } else {
                listItem
                    .onTapGesture {
                        if case .checkmark = model.trailingOption {
                            isSelected.toggle()
                        }
                    }
            }
        }
        .alert("Information icon tapped! Bon appétit", isPresented: $showAlert) {
            Button("close", role: .cancel) {}
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var listItem: some View {
        VStack {
            OBSListItem(
                title: title,
                subtitle: subtitle,
                leadingIcon: leadingIcon
            )
            OBSListItem(
                title: title,
                subtitle: subtitle,
                leadingIcon: leadingIcon,
                tralingText: Text("Details")
            )
            OBSListItem(
                title: title,
                subtitle: subtitle,
                leadingIcon: leadingIcon) {   
                    ODSListItemTrailing(text: Text("Details"))
                }
            
            OBSListItem(
                title: title,
                subtitle: subtitle,
                leadingIcon: leadingIcon
            ) {
                iButtonAction()
            }
            OBSListItem(
                title: title,
                subtitle: subtitle,
                leadingIcon: leadingIcon,
                checkmarkIsSelected: isSelected)

        }

    }
    
    // =====================
    // MARK: Private helpers
    // =====================
        
    private var title: Text {
        Text(recipe.title)
    }
    
    private var subtitle: Text? {
        if model.showSubtitle {
            return Text(recipe.subtitle)
        } else {
            return nil
        }
    }

    private var leadingIcon: ODSListItemLeadingIcon? {
        let emptyImage = Image("ods_empty", bundle: Bundle.ods)
        switch model.leadingIconOption {
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
    
    
    private var trailingAction: (() -> ODSListItemTrailing)? {
        if let trailingOption = model.trailingOption {
            return {
                self.trailingAction(for: trailingOption)
            }
        } else {
            return nil
        }
    }

    private func trailingAction(for option: ListItemTrailingOption) -> ODSListItemTrailing{
        switch option {
        case .textOnly:
            return ODSListItemTrailing(text: Text("Details"))
        case .iButton:
            return ODSListItemTrailing(action: iButtonAction)
        case .iButtonAndText:
            return ODSListItemTrailing(text: Text("Details"), action: iButtonAction)
        case .toggle:
            return ODSListItemTrailing(toogleIsOn: $isSelected)
        case .checkmark:
            return ODSListItemTrailing(checkmarkIsVisible: isSelected)
        }
    }
    
    // =====================
    // MARK: Buttons actions
    // =====================
    
    // Info button action
    private func iButtonAction() {
        showAlert = true
    }

}
