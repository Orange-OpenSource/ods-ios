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
import OrangeDesignSystem

struct BottomSheetVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: BottomSheetVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        PageContent(model: model)
            .modifier(BottomSheetModifier(model: model))
            .navigationBarTitle("Recipes", displayMode: .inline)
            
    }
}


fileprivate struct BottomSheetModifier: ViewModifier {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: BottomSheetVariantModel

    // ==========
    // MARK: Body
    // ==========
    @ViewBuilder
    func body(content: Content) -> some View {
        if model.showSubtitle {
            content
                .odsBottomSheet(title: "Recipes",
                                subtitle: model.showSubtitle ? "French products" : nil,
                                bottomSheetSize: $model.bottomSheetSize,
                                bottomSheetPosition: $model.bottomSheetPosition) {
                     BottonSheetContent(model: model)
                         .background(Color(UIColor.systemBackground))
                 }
        } else {
            content
                .odsBottomSheet(title: "Recipes",
                                 icon: model.showIcon ? Image("Heart_19371") : nil,
                                 bottomSheetSize: $model.bottomSheetSize,
                                 bottomSheetPosition: $model.bottomSheetPosition) {
                     BottonSheetContent(model: model)
                         .background(Color(UIColor.systemBackground))
                 }
        }
    }
}

fileprivate struct BottonSheetContent: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: BottomSheetVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        if model.contentType == .tutorial {
            tutorialPage()
        } else {
            examplePage()
        }
    }
    
    // =============
    // MARK: Helpers
    // =============
    
    private func tutorialPage() -> some View {
        ScrollView {
            if model.bottomSheetSize == .large {
                PageContent(model: model)
            }
        }
    }
    
    private func examplePage() -> some View {
        List {
            ForEach(RecipeBook.shared.recipes, id: \.title) { recipe in
                let listItemModel =
                ODSListStandardItemModel(title: recipe.title, leadingIcon: .icon(Image(recipe.iconName)))

                ODSListStandardItem(model: listItemModel)
                    .padding(.horizontal, ODSSpacing.s)
                    .listRowSeparator(Visibility.visible)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        if model.selectedRecipe?.title == recipe.title {
                            model.selectedRecipe = nil
                        } else {
                            model.selectedRecipe = recipe
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
}


fileprivate struct PageContent: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: BottomSheetVariantModel
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            if model.contentType == .example {
                exemplePage()
            } else {
                tutorialPage()
            }
        }
    }

    // ====================
    // MARK: Computed value
    // ====================

    @ViewBuilder
    private func exemplePage() -> some View {
        if let recipe = model.selectedRecipe {
            let cardModel =
            ODSCardVerticalImageFirstModel(title: recipe.title,
                                           subtitle: recipe.subtitle,
                                           imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                                           supportingText: recipe.description)
            ODSCardVerticalImageFirst(model: cardModel)
                .padding(.horizontal, ODSSpacing.s)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func tutorialPage() -> some View {
        if let message = message {
            Text(message)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.all, ODSSpacing.m)
        } else {
            EmptyView()
        }
    }
        
    private var message: String? {
        switch model.bottomSheetSize {
        case .hidden:
            return nil
        case .small:
            return
                """
                To open the bottom sheet :\n
                Drag the component up
                """
        case .medium:
            return
                """
                To open or close  the bottom sheet :\n
                Drag the handle up or down\n
                Scroll the content\n
                Tap the dimming area
                """
        case .large:
            return
                """
                To close the bottom sheet :\n
                Drag the handle down\n
                Scroll the content\n
                Tap the dimming area
                """
        }
    }
}
