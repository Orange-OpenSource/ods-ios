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

final class ActivityIndicatorModel: ObservableObject {

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
