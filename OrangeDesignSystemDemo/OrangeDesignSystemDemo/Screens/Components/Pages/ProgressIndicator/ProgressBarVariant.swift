//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ProgressBarVariant: View {

    // ======================
    // MARK: Store properties
    // ======================
    @Environment(\.theme) private var theme
    @ObservedObject var model: ProgressBarVariantModel
    @State private var secondsElapsed = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private let maxSeconds: CGFloat = 100.0

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            variant
        } options: {
            ProgressBarVariantOptions(model: model)
        }
    }

    // ====================
    // MARK: Private helper
    // ====================

    var variant: some View {
        VStack {
            ProgressView(value: secondsElapsed, total: maxSeconds) {
                if model.showLabel {
                    Label(title: { Text("screens.components.progress_indicators.downloading") }, icon: {
                        if model.showIconInLabel {
                            Image(systemName: "tray.and.arrow.down")
                        }
                    })
                }
            } currentValueLabel: {
                if model.showCurrentValue {
                    let percent = String(format: "%.0f", secondsElapsed)
                    Text("screens.components.progress_indicators.x_percent" <- percent)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .tint(theme.componentColors.accent)
            .onReceive(timer) { _ in
                if secondsElapsed < maxSeconds {
                    secondsElapsed += 1
                } else {
                    secondsElapsed = 0
                }
            }

            Spacer()
        }
        .padding(.all, ODSSpacing.m)
    }
}

final class ProgressBarVariantModel: ObservableObject {

    // ======================
    // MARK: Store properties
    // ======================

    @Published var showLabel: Bool
    @Published var showCurrentValue: Bool
    @Published var showIconInLabel: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        showLabel = true
        showIconInLabel = true
        showCurrentValue = true
    }
}

private struct ProgressBarVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: ProgressBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("screens.components.progress_indicators.toggle.label", isOn: $model.showLabel)
            if model.showLabel {
                Toggle("shared.icon", isOn: $model.showIconInLabel)
            }
            Toggle("screens.components.progress_indicators.toggle.current_value", isOn: $model.showCurrentValue)
        }
        .odsFont(.bodyLRegular)
        .padding(.all, ODSSpacing.m)
    }
}
