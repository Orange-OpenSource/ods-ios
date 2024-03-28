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

struct ColorIllustration: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject private var screenState: ScreenState
    @State private var showingModal = false
    let colorDescription: ODSColorDecription
    let bordered: Bool

    // ==========
    // MARK: Body
    // ==========

    var body: some View {

        let tap = TapGesture().onEnded { _ in showingModal.toggle() }

        VStack(alignment: .leading) {
            Rectangle()
                .fill(colorDescription.color)
                .border(bordered ? Color.secondary : Color.clear)
                .aspectRatio(1.0, contentMode: .fit)

            Text(colorDescription.assetName).odsFont(.headlineS)
                
            ColorName(colorDescription: colorDescription)

            Text(colorDescription.uiColor.hexa(colorScheme: screenState.colorScheme))
                .odsFont(.labelMRegular)
        }
        .background(Color(uiColor: UIColor.systemBackground))
        .colorScheme(self.screenState.colorScheme)
        .accessibilityElement()
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("a11y.tap_twice_to_get_more")
        .gesture(tap)
        .fullScreenCover(isPresented: $showingModal) {
            ColorDetail(colorDescription: colorDescription)
        }
    }

    // ============================
    // MARK: Private Implementation
    // ============================

    private var accessibilityLabel: String {
        let rgba = colorDescription.uiColor.rgba(colorScheme: screenState.colorScheme)
        return "a11y.color_details" <- [colorDescription.assetName,
                                        colorDescription.name(for: screenState.colorScheme) ??
                                        colorDescription.assetName,
                                        rgba.hexa]
    }
}

struct ColorName: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject private var screenState: ScreenState
    let colorDescription: ODSColorDecription

    // ============================
    // MARK: Body
    // ============================

    var body: some View {
        if let colorName = colorName {
            Text(colorName)
                .font(.system(.caption, design: .monospaced))
        }
    }

    // ============================
    // MARK: Private Implementation
    // ============================

    var colorName: String? {
        screenState.colorScheme == .light ? colorDescription.nameForLightScheme : colorDescription.nameForDarkScheme
    }
}
