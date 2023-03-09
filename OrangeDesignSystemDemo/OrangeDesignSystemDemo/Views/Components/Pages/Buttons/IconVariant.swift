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

// MARK: - Icon Variant

struct IconVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: IconVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: ODSSpacing.m) {
                    Text("Plain buttons are the most ubiquitous compoent found troughout applications. Consisting a icon, they are the most simple button style.")
                        .odsFont(.bodyRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VariantsTitle().frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .center, spacing: ODSSpacing.l) {
                        VStack(alignment: .center, spacing: ODSSpacing.s) {
                            Text("Icon (add)").odsFont(.headline).frame(maxWidth: .infinity, alignment: .leading)

                            ODSIconButton(image: Image("Add")) {}
                                .disabled(model.showDisabled)
                        }

                        VStack(alignment: .center, spacing: ODSSpacing.s) {
                            Text("Icon (info)").odsFont(.headline).frame(maxWidth: .infinity, alignment: .leading)

                            ODSIconButton(image: Image(systemName: "info.circle")) {}
                                .disabled(model.showDisabled)
                        }
                    }
                }
                .padding(.top, ODSSpacing.m)
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.bottom, 55)

            BottomSheet {
                IconVariantOptions(model: model)
            }
        }
        .background(Color("componentBackground2"))
    }
}

class IconVariantModel: ObservableObject {

    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showDisabled: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        showDisabled = false
    }
}


struct IconVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: IconVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            Toggle("Show disabled", isOn: $model.showDisabled)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}
