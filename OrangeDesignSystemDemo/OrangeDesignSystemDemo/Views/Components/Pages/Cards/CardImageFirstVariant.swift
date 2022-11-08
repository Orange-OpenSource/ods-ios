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

class CardImageFirstVariantModel: ObservableObject {

    @Published var showSubtitle: Bool
    @Published var showSupportingText: Bool
    @Published var showButton1: Bool
    @Published var showButton2: Bool

    init() {
        showSubtitle = true
        showSupportingText = true
        showButton1 = true
        showButton2 = true
    }

    var cardModel: ODSCardImageFirstModel {
        ODSCardImageFirstModel(title: cardExampleTitle,
                               subtitle: showSubtitle ? cardExampleSubtitle : nil,
                               image: Image("ods_empty", bundle: Bundle.ods),
                               supportingText: showSupportingText ? cardExampleSupportingText : nil)
    }
}

struct CardImageFirstVariant: View {

    @ObservedObject var model: CardImageFirstVariantModel

    var body: some View {
        ZStack {
            // Card demonstrator
            ScrollView {
                ODSCardImageFirst(model: model.cardModel) {
                    if model.showButton1 {
                        ODSButton(text: LocalizedStringKey("Button 1"), emphasis: .highest, variableWidth: true) {}
                    }
                } buttonContent2: {
                    if model.showButton2 {
                        ODSButton(text: LocalizedStringKey("Button 2"), emphasis: .highest, variableWidth: true) {}
                    }
                }
                .padding(.horizontal, ODSSpacing.s)
                .padding(.top, ODSSpacing.m)
            }

            BottomSheet(showContent: false) {
                CardImageFirstBottomSheetContent()
            }
            .environmentObject(model)
        }
    }
}

struct CardImageFirstBottomSheetContent: View {

    @EnvironmentObject var model: CardImageFirstVariantModel

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Subtitle", isOn: $model.showSubtitle)
            Toggle("Text", isOn: $model.showSupportingText)
            Toggle("Button 1", isOn: $model.showButton1)
            Toggle("Button 2", isOn: $model.showButton2)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
