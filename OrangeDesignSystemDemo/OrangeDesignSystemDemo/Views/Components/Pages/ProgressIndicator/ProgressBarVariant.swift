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
        ZStack {
            VStack {
                ProgressView(value: secondsElapsed, total: maxSeconds) {
                    if model.showLabel {
                        Label(title: {Text("Downloading...")}, icon: {
                            if model.showIconInLabel {
                                Image(systemName: "tray.and.arrow.down")
                            }
                        })
                    }
                } currentValueLabel: {
                    if model.showCurrentValue {
                        let percent = String(format: "%.0f", secondsElapsed)
                        Text("\(percent) %")
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
            
            BottomSheet() {
                ProgressBarVariantOptions(model: model)
            }
        }
    }
}

class ProgressBarVariantModel: ObservableObject {
    
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
            Toggle("Label", isOn: $model.showLabel)
            if model.showLabel {
                Toggle("Icon", isOn: $model.showIconInLabel)
            }
            Toggle("Current value", isOn: $model.showCurrentValue)
        }
        .odsFont(.bodyRegular)
        .padding(.all, ODSSpacing.m)
    }
}
