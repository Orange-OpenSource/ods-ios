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

struct ListItemSelectionVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ListItemSelectionVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ListItemSelectionVariantInner(model: model)
        } options: {
            ListItemSelectionVariantOptions(model: model)
        }
    }
}

private struct ListItemSelectionVariantInner: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ListItemSelectionVariantModel
    @State private var isSelected: Bool = true
    
    // =================
    // MARK: Initializer
    // =================

    init(model: ListItemSelectionVariantModel) {
        self.model = model
    }
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List {
            listItem
                .odsListItemStyle()
                .onTapGesture {
                    if case .checkmark = model.trailingOption {
                        isSelected.toggle()
                    }
                }
        }
        .refreshable {
            model.updateRecipe()
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }

    // =====================
    // MARK: Private helpers
    // =====================

    @ViewBuilder
    private var listItem: some View {
        switch model.trailingOption {
        case .toggle:
            ODSListItem(
                title: title,
                subtitle: subtitle,
                subtitleNumberOfLines: subtitleNumberOfLines,
                leading: leading,
                trailingToggleIsOn: $isSelected)

        case .checkmark:
            ODSListItem(
                title: title,
                subtitle: subtitle,
                subtitleNumberOfLines: subtitleNumberOfLines,
                leading: leading,
                trailingCheckmarkIsSelected: isSelected)
        }
    }

    private var title: Text {
        Text(model.recipe.title)
    }

    private var subtitle: Text? {
        switch model.subtitleOption {
        case .none: return nil
        case .oneLine, .twoLines: return Text(model.recipe.description)
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
        let emptyImage = Image("ods_empty", bundle: Bundle.ods)
        switch model.leadingOption {
        case .none:
            return nil
        case .icon:
            return .icon(Image(model.recipe.iconName))
        case .circle:
            return .circularImage(source: .asyncImage(model.recipe.url, emptyImage))
        case .square:
            return .squareImage(source: .asyncImage(model.recipe.url, emptyImage))
        case .wide:
            return .wideImage(source: .asyncImage(model.recipe.url, emptyImage))
        }
    }
}
