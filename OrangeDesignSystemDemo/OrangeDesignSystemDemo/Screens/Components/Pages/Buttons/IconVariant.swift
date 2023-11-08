//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

// ====================
// MARK: - Icon Variant
// ====================

struct IconVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: IconVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            variant
        } options: {
            IconVariantOptions(model: model)
        }
    }

    var variant: some View {
        ScrollView {
            VStack(spacing: ODSSpacing.m) {
                Text("screens.components.buttons.variant.description")
                    .odsFont(.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VariantsTitle().frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .center, spacing: ODSSpacing.l) {
                    VStack(alignment: .center, spacing: ODSSpacing.s) {
                        Text("screens.components.buttons.icon_add").odsFont(.headline).frame(maxWidth: .infinity, alignment: .leading)

                        ODSIconButton(image: Image("Add")) {}
                            .disabled(!model.showEnabled)
                    }

                    VStack(alignment: .center, spacing: ODSSpacing.s) {
                        Text("screens.components.buttons.icon_info").odsFont(.headline).frame(maxWidth: .infinity, alignment: .leading)

                        ODSIconButton(image: Image(systemName: "info.circle")) {}
                            .disabled(!model.showEnabled)
                    }
                }
            }
            .padding(.top, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
        }
        .padding(.bottom, 55)
        .background(Color("componentBackground2"))
    }
}

// ==========================
// MARK: - Icon Variant Model
// ==========================

class IconVariantModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showEnabled: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        showEnabled = true
    }
}

// ============================
// MARK: - Icon Variant Options
// ============================

struct IconVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: IconVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            Toggle("shared.enabled", isOn: $model.showEnabled)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}
