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
                        .odsFont(.bodyLRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityHidden(true)
                }

                if model.stepped {
                    ODSSlider(value: $value, in: range, step: 0.5) {
                        Text("screens.components.sliders.sample.volume")
                    } minimumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.1.fill")
                    } maximumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.3.fill")
                    } onEditingChanged: { isEditing in
                        Log.debug("isEdition: \(isEditing)")
                    }
                } else {
                    ODSSlider(value: $value, in: range) {
                        Text("screens.components.sliders.sample.volume")
                    } minimumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.1.fill")
                    } maximumValueLabel: {
                        SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.3.fill")
                    } onEditingChanged: { isEditing in
                        Log.debug("isEdition: \(isEditing)")
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

final class SliderVariantModel: ObservableObject {

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
            Toggle("screens.components.sliders.sample.side_icons", isOn: $model.showSideIcons)
            Toggle("screens.components.sliders.sample.display_value", isOn: $model.showValue)
            Toggle("screens.components.sliders.sample.stepped", isOn: $model.stepped)
        }
        .odsFont(.bodyLRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
