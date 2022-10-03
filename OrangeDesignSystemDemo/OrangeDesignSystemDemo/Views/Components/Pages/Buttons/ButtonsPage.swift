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
    @Published var showLargeLayout: Bool
    @Published var showLongText: Bool

    init() {
        showIcon = false
        showLargeLayout = false
        showLongText = false
    }

    func text(disbled: Bool) -> LocalizedStringKey {
        showLongText ? "Terms and conditions" : (disbled ? "Disabled" : "Enabled")
    }

    var icon: Image? {
        showIcon ? Image(systemName: "wrench") : nil
    }
}

struct ButtonPage: View {

    var body: some View {
        List {
            VStack {
                Image("Buttons - Shape")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ComponentDescription(text: "A custom shape button allows a user to perform an important call to action. This button that contains a text label and a supporting icon can be displayed")
                    .padding(.bottom, ODSSpacing.l)
                    .padding(.horizontal, ODSSpacing.m)

                VariantsTitle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.m)
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, ODSSpacing.none)

            NavigationLink {
                EmphasisButtons(model: ButtonContentModel())
                    .navigationTitle("Emphasis buttons")
            } label: {
                Item(text: "Emphasis", objectName: "ODSButton")
            }

            NavigationLink {
                FunctionalButtons(model: ButtonContentModel())
                    .navigationTitle("Functional buttons")
            } label: {
                Item(text: "Functional", objectName: "ODSFunctionalButton")
            }

            NavigationLink {
                IconButtons()
                    .navigationTitle("Icon buttons")
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

struct EmphasisButtons: View {
    @ObservedObject var model: ButtonContentModel

    var body: some View {
        ZStack {
            ScrollView {
                ForEach(ODSButton.Emphasis.allCases, id: \.rawValue) { emphasis in
                    VStack(alignment: .center) {
                        HStack {
                            Text("Emphasis: \(emphasis.rawValue)")
                            Spacer()
                        }

                        ODSButton(text: model.text(disbled: false),
                                  image: model.icon,
                                  emphasis: emphasis,
                                  largeLayout: model.showLargeLayout) {}

                        ODSButton(text: model.text(disbled: true),
                                  image: model.icon,
                                  emphasis: emphasis,
                                  largeLayout: model.showLargeLayout) {}
                            .disabled(true)
                    }
                }
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

struct FunctionalButtons: View {
    @ObservedObject var model: ButtonContentModel

    var body: some View {
        ZStack {
            ScrollView {
                ForEach(ODSFunctionalButton.Style.allCases, id: \.rawValue) { style in
                    VStack(alignment: .center) {
                        HStack {
                            Text("\(style.rawValue)")
                            Spacer()
                        }

                        ODSFunctionalButton(text: model.text(disbled: false),
                                            image: model.icon,
                                            style: style,
                                            largeLayout: model.showLargeLayout) {}

                        ODSFunctionalButton(text: model.text(disbled: true),
                                            image: model.icon,
                                            style: style,
                                            largeLayout: model.showLargeLayout) {}
                            .disabled(true)
                    }
                }
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.bottom, 55)
            .navigationTitle("Functional buttons")

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

struct IconButtons: View {

    var body: some View {
        ScrollView {
            VStack(spacing: ODSSpacing.xxl) {
                VStack(alignment: .center, spacing: ODSSpacing.none) {
                    Text("Info button").odsFont(.title2)

                    HStack(alignment: .center) {
                        Text("Enabled").odsFont(.bodyRegular)
                        ODSIconButton(image: Image(systemName: "info.circle")) {}
                    }
                    HStack(alignment: .center, spacing: ODSSpacing.none) {
                        Text("Disbaled").odsFont(.bodyRegular)
                        ODSIconButton(image: Image(systemName: "info.circle")) {}
                            .disabled(true)
                    }
                }

                VStack(alignment: .center, spacing: ODSSpacing.none) {
                    Text("Add button").odsFont(.title2)

                    HStack(alignment: .center) {
                        Text("Enabled").odsFont(.bodyRegular)
                        ODSIconButton(image: Image(systemName: "plus.circle")) {}
                    }
                    HStack(alignment: .center, spacing: ODSSpacing.none) {
                        Text("Disbaled").odsFont(.bodyRegular)
                        ODSIconButton(image: Image(systemName: "plus.circle")) {}
                            .disabled(true)
                    }
                }
            }
            .padding(.top, ODSSpacing.m)
        }
    }
}

struct ButtonsBottomSheetContent: View {

    @EnvironmentObject var model: ButtonContentModel

    var body: some View {
        VStack {
            Toggle("Show large layout", isOn: $model.showLargeLayout)
            Toggle("Show icon", isOn: $model.showIcon)
            Toggle("Show long text", isOn: $model.showLongText)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}
