//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct StandardListVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: StandardListVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            StandardListVariantInner(model: model)
        } options: {
            StandardListVariantOptions(model: model)
        }
    }
}

private struct StandardListVariantInner: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: StandardListVariantModel
    @State private var multiSelection: Set<UUID>? = nil

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List /* (selection: $multiSelection) */ {
            ForEach(model.itemModels, id: \.id) { itemModel in
                if model.showDetails {
                    NavigationLink(itemModel) {
                        Text("screens.components.lists.variant.clicked" <- itemModel.title)
                            .navigationTitle(itemModel.title)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(Visibility.visible)
                    .padding(.horizontal, ODSSpacing.s)
                } else {
                    ODSListStandardItem(model: itemModel)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(Visibility.visible)
                        .padding(.horizontal, ODSSpacing.s)
                }
            }
            .onMove(perform: model.move)
            .onDelete(perform: model.delete)
        }
        .toolbar { EditButton() }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .alert("screens.components.lists.alert", isPresented: $model.showSheetOnIButtonClicked) {
            Button("shared.close", role: .cancel) {}
        }
    }
}
