/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// ========================
// MARK: - Emphasis Variant
// ========================

struct EmphasisVariant: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: EmphasisAndFunctionnalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Text("screens.guidelines.buttons.variant.emphasis.description")
            .odsFont(.bodyRegular)
            .padding(.bottom, ODSSpacing.xs)
            .frame(maxWidth: .infinity, alignment: .leading)

        ForEach(ODSButton.Emphasis.allCases, id: \.rawValue) { emphasis in
            VStack(alignment: .center, spacing: ODSSpacing.s) {
                HStack {
                    Text("\(emphasis.rawValue)".capitalized)
                        .odsFont(.headline)
                    Spacer()
                }
                .accessibilityAddTraits(.isHeader)

                ODSButton(text: Text(model.text),
                          image: model.icon,
                          emphasis: emphasis,
                          fullWidth: model.showFullWidth) {}
                    .disabled(!model.showEnabled)
                    .accessibilityLabel("a11y.emphasis_button_hint" <- "\(emphasis.rawValue)")
            }
        }
    }
}

// ==========================
// MARK: - Functional Variant
// ==========================

struct FunctionalVariant: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: EmphasisAndFunctionnalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Text("screens.guidelines.buttons.variant.functional.description")
            .odsFont(.bodyRegular)
            .padding(.bottom, ODSSpacing.xs)
            .frame(maxWidth: .infinity, alignment: .leading)

        ForEach(ODSFunctionalButton.Style.allCases, id: \.rawValue) { style in
            VStack(alignment: .center, spacing: ODSSpacing.s) {
                HStack {
                    Text(description(for: style)).odsFont(.headline)
                    Spacer()
                }
                .accessibilityAddTraits(.isHeader)

                ODSFunctionalButton(text: Text(model.text),
                                    image: model.icon,
                                    style: style,
                                    fullWidth: model.showFullWidth) {}
                    .disabled(!model.showEnabled)
                    .accessibilityLabel("a11y.functional_button_hint" <- "\(style.rawValue)")
            }
        }
    }
    
    // ====================
    // MARK: Private helper
    // ====================

    private func description(for style: ODSFunctionalButton.Style) -> String {
        switch style {
        case .negative: return °°"screens.guidelines.buttons.styles.description.negative"
        case .positive: return °°"screens.guidelines.buttons.styles.description.positive"
        }
    }
}

// ========================================
// MARK: - Emphasis and Functionnal Variant
// ========================================

class EmphasisAndFunctionnalVariantModel: ObservableObject {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showIcon: Bool
    @Published var showFullWidth: Bool
    @Published var showLongText: Bool
    @Published var showEnabled: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        showIcon = false
        showFullWidth = false
        showLongText = false
        showEnabled = true
    }

    // =====================
    // MARK: Computed values
    // =====================

    var text: LocalizedStringKey {
        showLongText ? "screens.guidelines.buttons.variant.long" : (showEnabled ? "shared.enabled" : "shared.disabled")
    }

    var icon: Image? {
        showIcon ? Image("Add") : nil
    }
}

struct EmphasisAndFunctionalVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: EmphasisAndFunctionnalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            Toggle("shared.icon", isOn: $model.showIcon)
            Toggle("screens.guidelines.toggle.full_width", isOn: $model.showFullWidth)
            Toggle("shared.enabled", isOn: $model.showEnabled)
            Toggle("shared.long_text", isOn: $model.showLongText)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}
