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

struct EmphasisVariant: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: EmphasisAndFunctionnalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Text("High emphasis buttons are used to guide the user toward the primary call to action. Multiple buttons can be combined on the same screen to focus attention on the most important action while offering alternative actions. When using multiple buttons in a screen only one high emphasis button can be used. Those buttons can also include a contextual icon.")
            .odsFont(.bodyRegular)
            .padding(.bottom, ODSSpacing.xs)
            .frame(maxWidth: .infinity, alignment: .leading)

        ForEach(ODSButton.Emphasis.allCases, id: \.rawValue) { emphasis in
            VStack(alignment: .center, spacing: ODSSpacing.s) {
                HStack {
                    Text("\(emphasis.rawValue)".capitalized)
                        .odsFont(.headline)
                    Spacer()
                }
                .accessibilityAddTraits(.isHeader)

                ODSButton(text: model.text,
                          image: model.icon,
                          emphasis: emphasis,
                          variableWidth: model.showVariableWidth) {}
                    .disabled(model.showDisabled)
                    .accessibilityLabel("\(emphasis.rawValue) emphasis button")
            }
        }
    }
}

struct FunctionalVariant: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: EmphasisAndFunctionnalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        Text("If required, colour versions can also be used to inform users of positive or negative destructive actions.")
            .odsFont(.bodyRegular)
            .padding(.bottom, ODSSpacing.xs)
            .frame(maxWidth: .infinity, alignment: .leading)

        ForEach(ODSFunctionalButton.Style.allCases, id: \.rawValue) { style in
            VStack(alignment: .center, spacing: ODSSpacing.s) {
                HStack {
                    Text(description(for: style)).odsFont(.headline)
                    Spacer()
                }
                .accessibilityAddTraits(.isHeader)

                ODSFunctionalButton(text: model.text,
                                    image: model.icon,
                                    style: style,
                                    variableWidth: model.showVariableWidth) {}
                    .disabled(model.showDisabled)
                    .accessibilityLabel("\(style.rawValue) functional button")
            }
        }
    }
    
    // ====================
    // MARK: Private helper
    // ====================

    private func description(for style: ODSFunctionalButton.Style) -> String {
        switch style {
        case .negative: return "Negative"
        case .positive: return "Positive"
        }
    }
}

// MARK: - Emphasis and Functionnal Variant

class EmphasisAndFunctionnalVariantModel: ObservableObject {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showIcon: Bool
    @Published var showVariableWidth: Bool
    @Published var showLongText: Bool
    @Published var showDisabled: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        showIcon = false
        showVariableWidth = false
        showLongText = false
        showDisabled = false
    }

    // =====================
    // MARK: Computed values
    // =====================

    var text: LocalizedStringKey {
        showLongText ? "Terms and conditions" : (showDisabled ? "Disabled" : "Enabled")
    }

    var icon: Image? {
        showIcon ? Image("Add") : nil
    }
}

struct EmphasisAndFunctionalVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: EmphasisAndFunctionnalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            Toggle("Show icon", isOn: $model.showIcon)
            Toggle("Show variable width", isOn: $model.showVariableWidth)
            Toggle("Show disabled", isOn: $model.showDisabled)
            Toggle("Show long text", isOn: $model.showLongText)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}
