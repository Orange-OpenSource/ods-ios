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

struct EmphasisVariants: View {
    @ObservedObject var model: ButtonContentModel

    var body: some View {
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

struct FunctionalVariants: View {
    @ObservedObject var model: ButtonContentModel

    var body: some View {
        Text("If required, colour versions can also be used to inform users of positive or negative destructive actions.")
            .odsFont(.bodyRegular)
            .frame(maxWidth: .infinity, alignment: .leading)

        ForEach(ODSFunctionalButton.Style.allCases, id: \.rawValue) { style in
            VStack(alignment: .center, spacing: ODSSpacing.s) {
                HStack {
                    Text("\(style.rawValue)").odsFont(.headline)
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
}

struct IconVariant: View {
    @ObservedObject var model: IconButtonModel

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: ODSSpacing.m) {
                    Text("Plain buttons are the most ubiquitous compoent found troughout applications. Consisting a icon, they are the most simple button style.")
                        .odsFont(.bodyRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VariantsTitle()
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

            BottomSheet(showContent: false) {
                IconButtonBottomSheetContent()
            }
            .environmentObject(model)
        }
        .background(Color("componentBackground2"))
    }
}

struct IconButtonBottomSheetContent: View {

    @EnvironmentObject var model: IconButtonModel

    var body: some View {
        VStack {
            Toggle("Show disabled", isOn: $model.showDisabled)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}
