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

                VariantsTitle()
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .center, spacing: ODSSpacing.l) {
                    VStack(alignment: .leading, spacing: ODSSpacing.s) {
                        Text("screens.components.buttons.icon_add")
                            .odsFont(.headlineS)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            Spacer()
                            ODSIconButton(image: Image("Add")) {}
                                .disabled(!model.showEnabled)
                            Spacer()
                        }
                    }
                    .accessibilityElement(children: .combine)

                    VStack(alignment: .leading, spacing: ODSSpacing.s) {
                        Text("screens.components.buttons.icon_info")
                            .odsFont(.headlineS)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack {
                            Spacer()
                            ODSIconButton(image: Image(systemName: "info.circle")) {}
                                .disabled(!model.showEnabled)
                            Spacer()
                        }
                    }
                    .accessibilityElement(children: .combine)
                }
                .accessibilityHint(model.text)
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

    @Published var showLongText: Bool
    @Published var showEnabled: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        showLongText = false
        showEnabled = true
    }
    
    // =====================
    // MARK: Computed values
    // =====================

    var text: LocalizedStringKey {
        showLongText ? "screens.components.buttons.variant.long" : (showEnabled ? "shared.enabled" : "shared.disabled")
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
