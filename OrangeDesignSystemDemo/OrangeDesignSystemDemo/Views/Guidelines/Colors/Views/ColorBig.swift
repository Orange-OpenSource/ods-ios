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

struct ColorBig: View {

    let color: ODSColor
    @EnvironmentObject var screenState: ScreenState
    @State private var showingModal = false

    var bordered: Bool

    var colorName: String {
        color.displayName(forScheme: screenState.colorScheme)
    }

    var body: some View {

        let tap = TapGesture().onEnded { _ in showingModal.toggle() }

        VStack(alignment: .leading) {
            if bordered {
                Rectangle()
                    .fill(color.color)
                    .border(Color.secondary)
                    .aspectRatio(1.0, contentMode: .fit)
            } else {
                Rectangle()
                    .fill(color.color)
                    .aspectRatio(1.0, contentMode: .fit)
            }

            Text(color.displayName(forScheme: screenState.colorScheme))
                .odsFont(.headline)
                .fixedSize(horizontal: false, vertical: true)

            Text(color.rawValue)
                .font(.system(.caption, design: .monospaced))
                .fixedSize(horizontal: false, vertical: true)

            Text(color.rgb(forScheme: screenState.colorScheme).displayableValue)
                .odsFont(.caption1Regular)
                .fixedSize(horizontal: false, vertical: true)

            Text(color.hexa(forScheme: screenState.colorScheme))
                .odsFont(.caption1Regular)
                .fixedSize(horizontal: false, vertical: true)
        }
        .background(Color(uiColor: UIColor.systemBackground))
        .colorScheme(screenState.colorScheme)
        .gesture(tap)
        .accessibilityElement()
        .accessibilityLabel(accessibilityLabel)
        .accessibilityHint("Tap twice to get more information")
        .fullScreenCover(isPresented: $showingModal) { ColorDetail(color: self.color) }
    }

    var accessibilityLabel: String {
        "\(colorName), "
            + "Token name is \(color.rawValue), "
            + "RVB value is \(color.rgb(forScheme: screenState.colorScheme).accessibilityLabel)"
            + "Hexa value is \(color.hexa(forScheme: screenState.colorScheme))"
    }
}
