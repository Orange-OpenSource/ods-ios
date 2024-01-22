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
