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

import Foundation
import OrangeDesignSystem
import SwiftUI

struct ColorSmall: View {

    let color: ODSColor
    @EnvironmentObject var screenState: ScreenState
    @State private var showingModal = false

    var colorName: String {
        color.displayName(forScheme: screenState.colorScheme)
    }

    var body: some View {

        let tap = TapGesture().onEnded { _ in showingModal.toggle() }

        VStack(alignment: .leading) {
            Rectangle()
                .fill(color.color)
                .aspectRatio(1.0, contentMode: .fit)
            Text(colorName).odsFont(.headline)
            Text(color.hexa(forScheme: screenState.colorScheme)).odsFont(.caption1Regular)
        }
        .background(Color(uiColor: UIColor.systemBackground))
        .colorScheme(self.screenState.colorScheme)
        .accessibilityElement()
        .accessibilityLabel(Text(accessibilityLabel))
        .gesture(tap)
        .fullScreenCover(isPresented: $showingModal) { ColorDetail(color: self.color) }
    }

    var accessibilityLabel: String {
        "\(colorName), "
            + "Token name is \(color.rawValue) . "
            + "RVB value is \(color.rgb(forScheme: screenState.colorScheme).accessibilityLabel) . "
            + "Hex value is \(color.hexa(forScheme: screenState.colorScheme))"
    }
}
