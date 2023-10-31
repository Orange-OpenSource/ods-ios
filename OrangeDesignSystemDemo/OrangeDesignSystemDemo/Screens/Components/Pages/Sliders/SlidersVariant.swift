//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct SliderVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: SliderVariantModel
    @State private var value = 5.0
    private let range = 0 ... 10.0

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            variant
        } options: {
            SliderVariantOptions(model: model)
        }
    }

    // =====================
    // MARK: Private Helpers
    // =====================
    var variant: some View {
        ScrollView {
            VStack {
                if model.showValue {
                    Text(String(format: "%.2f", value))
                        .odsFont(.bodyRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityHidden(true)
                }

                if model.stepped {
                    ODSSlider(value: $value, in: range, step: 0.5) {
                        Text("screens.guidelines.sliders.sample.volume")
                    } minimumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.1.fill")
                    } maximumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.3.fill")
                    } onEditingChanged: { isEditing in
                        print("isEdition: \(isEditing)")
                    }
                } else {
                    ODSSlider(value: $value, in: range) {
                        Text("screens.guidelines.sliders.sample.volume")
                    } minimumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.1.fill")
                    } maximumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.3.fill")
                    } onEditingChanged: { isEditing in
                        print("isEdition: \(isEditing)")
                    }
                }
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.top, ODSSpacing.m)
        }
    }

    @ViewBuilder
    func SliderLabel(show: Bool, systemName: String) -> some View {
        if show {
            Image(systemName: systemName).accessibilityHidden(true)
        }
    }
}

class SliderVariantModel: ObservableObject {

    // ======================
    // MARK: Store properties
    // ======================

    @Published var showSideIcons: Bool
    @Published var showValue: Bool
    @Published var stepped: Bool

    // ==================
    // MARK: Initializers
    // ==================

    init() {
        showSideIcons = true
        showValue = true
        stepped = false
    }
}

struct SliderVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: SliderVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("screens.guidelines.sliders.sample.side_icons", isOn: $model.showSideIcons)
            Toggle("screens.guidelines.sliders.sample.display_value", isOn: $model.showValue)
            Toggle("screens.guidelines.sliders.sample.stepped", isOn: $model.stepped)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
