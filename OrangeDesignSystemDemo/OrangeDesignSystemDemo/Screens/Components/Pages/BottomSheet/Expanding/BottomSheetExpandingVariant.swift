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
                .odsBottomSheetExpanding(title: "Recipes",
                                subtitle: "French products",
                                bottomSheetSize: $model.bottomSheetSize,
                                content: bottomSheetContent)
        } else {
            if model.showIcon {
                content
                    .odsBottomSheetExpanding(title: "Recipes",
                                    icon: Image("Heart_19371"),
                                    bottomSheetSize: $model.bottomSheetSize,
                                    content: bottomSheetContent)
            } else {
                content
                    .odsBottomSheetExpanding(title: "Recipes",
                                    bottomSheetSize: $model.bottomSheetSize,
                                    content: bottomSheetContent)
            }
        }
    }
    
    private func bottomSheetContent() -> some View {
        BottonSheetContent(model: model)
            .background(Color(UIColor.systemBackground))

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
    @ViewBuilder
    private func tutorialPage() -> some View {
        TutorialText(message: model.tutorialTextOnBottomSheetContent)
    }
    
    private func examplePage() -> some View {
//        List {
        ForEach(RecipeBook.shared.recipes, id: \.title) { recipe in
            ODSListItem(title: Text(recipe.title), leading: .icon(Image(recipe.iconName)))
                .odsListItemStyle()
                .onTapGesture {
                    model.selectedRecipe = recipe
                }
        }
//        }
//        .listStyle(.plain)
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
            ODSCardVerticalImageFirst(
                title: Text(recipe.title),
                imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                subtitle: Text(recipe.subtitle),
                text: Text(recipe.description)) {
                    Button("Start preparing") {}
                }
                .padding(.horizontal, ODSSpacing.s)
        }
    }
    
    @ViewBuilder
    private func tutorialPage() -> some View {
        TutorialText(message: model.tutorialTextOnPageContent)
    }
}

struct TutorialText: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    let message: String?
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        if let message = message {
            Text(message)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.all, ODSSpacing.m)
        }
    }
}
