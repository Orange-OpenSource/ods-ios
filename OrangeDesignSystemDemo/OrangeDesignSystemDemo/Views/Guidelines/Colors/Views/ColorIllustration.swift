//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
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
        .accessibilityHint("Tap twice to get more information")
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
        return "asset name: \(colorDescription.assetName),"
        + "RGB value is \(rgba.accessibilityLabel) . "
        + "Hex value is \(rgba.hexa)"
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
        if let colorName {
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
