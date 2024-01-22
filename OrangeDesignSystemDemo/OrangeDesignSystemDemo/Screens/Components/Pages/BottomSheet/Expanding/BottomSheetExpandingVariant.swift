//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import OrangeDesignSystem
import SwiftUI

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

private struct BottomSheetModifier: ViewModifier {

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
                .odsBottomSheetExpanding(title: °°"screens.components.bottom_sheets.sample.title",
                                         subtitle: °°"screens.components.bottom_sheets.sample.subtitle",
                                         bottomSheetSize: $model.bottomSheetSize,
                                         content: bottomSheetContent)
        } else {
            if model.showIcon {
                content
                    .odsBottomSheetExpanding(title: °°"screens.components.bottom_sheets.sample.title",
                                             icon: Image("Heart_19371"),
                                             bottomSheetSize: $model.bottomSheetSize,
                                             content: bottomSheetContent)
            } else {
                content
                    .odsBottomSheetExpanding(title: °°"screens.components.bottom_sheets.sample.title",
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

private struct BottonSheetContent: View {

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
        ForEach(RecipeBook.shared.recipes, id: \.id) { recipe in
            ODSListItem(title: Text(recipe.title), leading: .icon(Image(recipe.iconName)))
                .odsListItemStyle()
                .onTapGesture {
                    model.selectedRecipe = recipe
                }
        }
    }
}

private struct PageContent: View {

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
                text: Text(recipe.description))
            {
                Button("screens.components.bottom_sheets.sample.start_preparing") {}
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
