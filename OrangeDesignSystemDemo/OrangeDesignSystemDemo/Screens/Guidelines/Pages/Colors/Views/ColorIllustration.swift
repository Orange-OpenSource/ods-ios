/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

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
            
            ColorName(colorDescription: colorDescription)
            
            Text(colorDescription.assetName)
                .font(.system(.caption, design: .monospaced))
            
            Text(colorDescription.uiColor.hexa(colorScheme: screenState.colorScheme))
                .odsFont(.caption1Regular)
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
        return "a11y.color_details" <- [colorDescription.assetName, rgba.accessibilityLabel, rgba.hexa]
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
            Text(colorName).odsFont(.headline)
        }
    }

    // ============================
    // MARK: Private Implementation
    // ============================

    var colorName: String? {
        screenState.colorScheme == .light ? colorDescription.nameForLightScheme : colorDescription.nameForDarkScheme
    }
}
