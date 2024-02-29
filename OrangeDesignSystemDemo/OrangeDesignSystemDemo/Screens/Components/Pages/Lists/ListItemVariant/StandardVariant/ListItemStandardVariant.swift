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
    
    // =================
    // MARK: Initializer
    // =================

    init(model: ListItemStandardVariantModel) {
        self.model = model
    }
    
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
        .refreshable {
            model.updateRecipe()
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
                subtitleNumberOfLines: subtitleNumberOfLines,
                leading: leading,
                trailingText: Text("screens.components.list.details"))
            {
                iButtonAction()
            }
        case (true, false):
            ODSListItem(
                title: title,
                subtitle: subtitle,
                subtitleNumberOfLines: subtitleNumberOfLines,
                leading: leading,
                trailingText: Text("screens.components.list.details"))

        case (false, true):
            ODSListItem(
                title: title,
                subtitle: subtitle,
                subtitleNumberOfLines: subtitleNumberOfLines,
                leading: leading)
            {
                iButtonAction()
            }

        case (false, false):
            ODSListItem(
                title: title,
                subtitle: subtitle,
                subtitleNumberOfLines: subtitleNumberOfLines,
                leading: leading)
        }
    }

    private var title: Text {
        Text(model.recipe.title)
    }

    private var subtitle: Text? {
        switch model.subtitleOption {
        case .none: return nil
        case .oneLine, .twoLines: return Text(model.recipe.subtitle)
        }
    }

    var subtitleNumberOfLines: ODSListItem.SubtitleNumberOfLines? {
        switch model.subtitleOption {
        case .none: return nil
        case .oneLine: return .one
        case .twoLines: return .two
        }
    }

    private var leading: ODSListItem.Leading? {
        let emptyImage = Image("placeholder", bundle: Bundle.ods)
        switch model.leadingOption {
        case .none:
            return nil
        case .icon:
            return .icon(Image(model.recipe.iconName))
        case .appIcon:
            if let appImage = appImage {
                return .appIcon(source: .image(appImage))
            } else {
                return .appIcon(source: .asyncImage(model.recipe.url, emptyImage))
            }
        case .circle:
            return .circularImage(source: .asyncImage(model.recipe.url, emptyImage))
        case .square:
            return .squareImage(source: .asyncImage(model.recipe.url, emptyImage))
        case .wide:
            return .wideImage(source: .asyncImage(model.recipe.url, emptyImage))
        }
    }

    // =====================
    // MARK: Buttons actions
    // =====================

    // Info button action
    private func iButtonAction() {
        showAlert = true
    }
    
    private var appImage: Image? {
        Bundle.main.appIconFileName
            .flatMap { UIImage(named: $0) }
            .map { Image(uiImage: $0) }
    }
}
