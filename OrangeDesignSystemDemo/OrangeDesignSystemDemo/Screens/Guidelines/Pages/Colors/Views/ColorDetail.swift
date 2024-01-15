//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ColorDetail: View {

    // ======================
    // MARK: Store properties
    // ======================

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var screenState: ScreenState

    let colorDescription: ODSColorDecription
    let usage = °°"misc.coming_soon"

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {

            BackgroundBlurView().edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {

                Rectangle().fill(colorDescription.color)
                    .frame(width: 300, height: 150)

                VStack(alignment: .leading, spacing: 3) {
                    Text(colorDescription.assetName).odsFont(.headlineS)
                    Text(colorDescription.uiColor.rgba(colorScheme: screenState.colorScheme).displayableValue).odsFont(.labelMRegular)
                    Text(colorDescription.uiColor.hexa(colorScheme: screenState.colorScheme)).odsFont(.labelMRegular)

                    Text("misc.usage")
                        .odsFont(.headlineS)
                        .padding(.top, ODSSpacing.l)
                    Text(usage).odsFont(.labelMRegular)
                }
                .padding(EdgeInsets(top: ODSSpacing.s, leading: ODSSpacing.m, bottom: ODSSpacing.l, trailing: ODSSpacing.m))
            }
            .background(Color(uiColor: UIColor.systemGray6))
            .colorScheme(screenState.colorScheme)
            .cornerRadius(10)
            .accessibilityElement()
            .accessibilityLabel(accessibilityLabel)
        }
        .onTapGesture {
            dismiss()
        }
    }

    // ============================
    // MARK: Private Implementation
    // ============================

    var accessibilityLabel: String {
        "\(colorDescription.assetName), "
            + "Usage, \(usage)"
    }
}
