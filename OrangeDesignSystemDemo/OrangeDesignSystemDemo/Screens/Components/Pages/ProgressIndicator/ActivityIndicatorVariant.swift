//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ActivityIndicatorVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: ActivityIndicatorModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            VStack {
                ProgressView {
                    if model.showLabel {
                        Text("screens.components.progress_indicators.toggle.loading")
                    }
                }
                Spacer()
            }
            .padding(.all, ODSSpacing.m)
        } options: {
            ActivityIndicatorVariantOptions(model: model)
        }
    }
}

class ActivityIndicatorModel: ObservableObject {

    // ======================
    // MARK: Store properties
    // ======================

    @Published var showLabel: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        showLabel = true
    }
}

private struct ActivityIndicatorVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: ActivityIndicatorModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("screens.components.progress_indicators.toggle.label", isOn: $model.showLabel)
                .odsFont(.bodyLRegular)
                .padding(.all, ODSSpacing.m)
        }
    }
}
