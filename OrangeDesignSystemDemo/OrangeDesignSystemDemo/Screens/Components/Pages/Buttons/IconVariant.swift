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
                    .odsFont(.bodyLRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VariantsTitle().frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .center, spacing: ODSSpacing.l) {
                    VStack(alignment: .center, spacing: ODSSpacing.s) {
                        Text("screens.components.buttons.icon_add").odsFont(.headlineS).frame(maxWidth: .infinity, alignment: .leading)

                        ODSIconButton(image: Image("Add")) {}
                            .disabled(!model.showEnabled)
                    }

                    VStack(alignment: .center, spacing: ODSSpacing.s) {
                        Text("screens.components.buttons.icon_info").odsFont(.headlineS).frame(maxWidth: .infinity, alignment: .leading)

                        ODSIconButton(image: Image(systemName: "info.circle")) {}
                            .disabled(!model.showEnabled)
                    }
                }
            }
            .padding(.top, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
        }
        .padding(.bottom, 55)
    }
}

// ==========================
// MARK: - Icon Variant Model
// ==========================

final class IconVariantModel: ObservableObject {

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
