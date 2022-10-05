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

class ButtonContentModel: ObservableObject {
    @Published var showIcon: Bool
    @Published var showVariableWidth: Bool
    @Published var showLongText: Bool
    @Published var showDisabled: Bool

    init() {
        showIcon = false
        showVariableWidth = false
        showLongText = false
        showDisabled = false
    }

    var text: LocalizedStringKey {
        showLongText ? "Terms and conditions" : (showDisabled ? "Disabled" : "Enabled")
    }

    var icon: Image? {
        showIcon ? Image(systemName: "wrench") : nil
    }
}

struct ButtonPage: View {

    var body: some View {
        List {
            VStack(spacing: ODSSpacing.none) {
                Image("Buttons - Shape")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ComponentDescription(text: "A custom shape button allows a user to perform an important call to action. This button that contains a text label and a supporting icon can be displayed")
                    .padding(.top, ODSSpacing.m)
                    .padding(.horizontal, ODSSpacing.m)

                VariantsTitle()
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.top, ODSSpacing.l)
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, ODSSpacing.none)

            NavigationLink {
                ButtonVariant(model: ButtonContentModel()) { model in
                    EmphasisVariants(model: model)
                }
                .navigationTitle("Emphasis")
            } label: {
                Item(text: "Emphasis", objectName: "ODSButton")
            }

            NavigationLink {
                ButtonVariant(model: ButtonContentModel()) { model in
                    FunctionalVariants(model: model)
                }
                .navigationTitle("Functional")
            } label: {
                Item(text: "Functional", objectName: "ODSFunctionalButton")
            }

            NavigationLink {
                IconButtons()
                    .navigationTitle("Icon")
            } label: {
                Item(text: "Icons", objectName: "ODSIconButton")
            }
        }
        .listRowSeparator(Visibility.visible)
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.bottom, ODSSpacing.m)
        .background(ODSColor.componentBackground2.color)
    }

    @ViewBuilder func Item(text: String, objectName: String) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .odsFont(.bodyRegular)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text(objectName)
                .font(.system(.caption, design: .monospaced))
                .padding(.bottom, ODSSpacing.none)
        }
    }
}

struct ButtonVariant<Variant>: View where Variant: View {
    let model: ButtonContentModel

    let contentView: (_ model: ButtonContentModel) -> Variant

    init(model: ButtonContentModel, @ViewBuilder contentView: @escaping (_ model: ButtonContentModel) -> Variant) {
        self.model = model
        self.contentView = contentView
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: ODSSpacing.m) {
                    contentView(model)
                }
                .padding(.top, ODSSpacing.m)
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.bottom, 55)

            BottomSheet(showContent: false) {
                ButtonsBottomSheetContent()
            }
            .environmentObject(model)
        }

        .padding(.top, ODSSpacing.none)
        .padding(.bottom, ODSSpacing.m)
        .background(ODSColor.componentBackground2.color)
    }
}

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

                ODSButton(text: model.text,
                          image: model.icon,
                          emphasis: emphasis,
                          variableWidth: model.showVariableWidth) {}
                    .disabled(model.showDisabled)
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

                ODSFunctionalButton(text: model.text,
                                    image: model.icon,
                                    style: style,
                                    variableWidth: model.showVariableWidth) {}
                    .disabled(model.showDisabled)
            }
        }
    }
}

struct IconButtons: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ODSSpacing.m) {
                Text("Plain buttons are the most ubiquitous compoent found troughout applications. Consisting of either a text label or a icon, they are the most simple button style.")
                    .odsFont(.bodyRegular)
                    .frame(maxWidth: .infinity, alignment: .leading)

                VariantsTitle()

                VStack(alignment: .center, spacing: ODSSpacing.none) {
                    Text("Icon (add)").odsFont(.headline).frame(maxWidth: .infinity, alignment: .leading)

                    ODSIconButton(image: Image(systemName: "info.circle")) {}
                }

                VStack(alignment: .center, spacing: ODSSpacing.none) {
                    Text("Icon (info)").odsFont(.headline).frame(maxWidth: .infinity, alignment: .leading)

                    ODSIconButton(image: Image(systemName: "plus.circle")) {}
                }
            }
            .padding(.top, ODSSpacing.m)
            .padding(.horizontal, ODSSpacing.m)
        }
    }
}

struct ButtonsBottomSheetContent: View {

    @EnvironmentObject var model: ButtonContentModel

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
