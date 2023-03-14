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

struct SliderVariant: View {
    
    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: SliderVariantModel
    @State private var value = 5.0
    private let range = 0 ... 10.0

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    if model.showValue {
                        Text(String(format: "%.2f", value))
                            .odsFont(.bodyRegular)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityHidden(true)
                    }
                    
                    if model.stepped {
                        ODSSlider(value: $value, in: range, step: 0.5) {
                            Text("Volume")
                        } minimumValueLabel: {
                            SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.1.fill")
                        } maximumValueLabel: {
                            SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.3.fill")
                        } onEditingChanged: { isEditing in
                            print("isEdition: \(isEditing)")
                        }
                    } else {
                        ODSSlider(value: $value, in: range) {
                            Text("Volume")
                        } minimumValueLabel: {
                            SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.1.fill")
                        } maximumValueLabel: {
                            SliderLabel(show: model.showSideIcons, systemName: "speaker.wave.3.fill")
                        } onEditingChanged: { isEditing in
                            print("isEdition: \(isEditing)")
                        }
                    }
                }
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
            }

            BottomSheet {
                SliderVariantOptions(model: model)
            }
        }
    }
    
    // =====================
    // MARK: Private Helpers
    // =====================
    @ViewBuilder
    func SliderLabel(show: Bool, systemName: String) -> some View {
        if show {
            Image(systemName: systemName).accessibilityHidden(true)
        }
    }
}

class SliderVariantModel: ObservableObject {

    // ======================
    // MARK: Store properties
    // ======================

    @Published var showSideIcons: Bool
    @Published var showValue: Bool
    @Published var stepped: Bool

    // ==================
    // MARK: Initializers
    // ==================
    
    init() {
        showSideIcons = true
        showValue = true
        stepped = false
    }
}

struct SliderVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: SliderVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Side icons", isOn: $model.showSideIcons)
            Toggle("Display value", isOn: $model.showValue)
            Toggle("Stepped (0.5)", isOn: $model.stepped)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
