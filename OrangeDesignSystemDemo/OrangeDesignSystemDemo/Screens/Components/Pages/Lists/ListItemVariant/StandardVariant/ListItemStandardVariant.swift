//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ListItemStandardVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ListItemStandardVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ListItemStandardVariantInner(model: model)
        } options: {
            ListItemStandardVariantOptions(model: model)
        }
    }
}

private struct ListItemStandardVariantInner: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ListItemStandardVariantModel
    @State private var showAlert: Bool = false
    private let recipe: Recipe = RecipeBook.shared.recipes[0]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List {
            if model.navigate {
                NavigationLink {
                    Text("shared.bon_app")
                } label: {
                    listItem
                }
                .odsListItemStyle()
            } else {
                listItem
                    .odsListItemStyle()
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .alert("screens.components.lists.alert", isPresented: $showAlert) {
            Button("shared.close", role: .cancel) {}
        }
    }

    // =====================
    // MARK: Private helpers
    // =====================

    @ViewBuilder
    private var listItem: some View {
        let showText = model.trailingOptions.contains { $0 == .text }
        let showIButton = model.trailingOptions.contains { $0 == .iButton }

        switch (showText, showIButton) {
        case (true, true):
            ODSListItem(
                title: title,
                subtitle: subtitle,
                leading: leading,
                trailingText: Text("screens.components.list.details"))
            {
                iButtonAction()
            }
        case (true, false):
            ODSListItem(
                title: title,
                subtitle: subtitle,
                leading: leading,
                trailingText: Text("screens.components.list.details"))

        case (false, true):
            ODSListItem(
                title: title,
                subtitle: subtitle,
                leading: leading)
            {
                iButtonAction()
            }

        case (false, false):
            ODSListItem(
                title: title,
                subtitle: subtitle,
                leading: leading)
        }
    }

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

    private var leading: ODSListItem.Leading? {
        let emptyImage = Image("ods_empty", bundle: Bundle.ods)
        switch model.leadingOption {
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

    // =====================
    // MARK: Buttons actions
    // =====================

    // Info button action
    private func iButtonAction() {
        showAlert = true
    }
}
