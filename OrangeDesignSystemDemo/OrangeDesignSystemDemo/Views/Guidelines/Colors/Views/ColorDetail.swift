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

struct ColorDetail: View {
    
    // ============================
    // MARK: Store properties
    // ============================

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var screenState: ScreenState

    let colorDescription: ODSColorDecription
    let usage = "Coming soon ..."

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
                    Text(colorDescription.assetName).odsFont(.headline)
                    Text(colorDescription.uiColor.rgba(colorScheme: screenState.colorScheme).displayableValue).odsFont(.caption1Regular)
                    Text(colorDescription.uiColor.hexa(colorScheme: screenState.colorScheme)).odsFont(.caption1Regular)

                    Text("Usage")
                        .odsFont(.headline)
                        .padding(.top, ODSSpacing.l)
                    Text(usage).odsFont(.caption1Regular)
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
