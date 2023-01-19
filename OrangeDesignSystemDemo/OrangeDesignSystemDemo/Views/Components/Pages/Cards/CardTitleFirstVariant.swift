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

class CardTitleFirstVariantModel: ObservableObject {
    
    @Published var showThumbnail: Bool
    @Published var showSubtitle: Bool
    @Published var showSupportingText: Bool
    @Published var showButton1: Bool
    @Published var showButton2: Bool
    @Published var showAlert: Bool
    var alertText: String = ""

    init() {
        showThumbnail = true
        showSubtitle = true
        showSupportingText = true
        showButton1 = true
        showButton2 = true
        showAlert = false
    }

    var cardModel: ODSCardTitleFirstModel {
        ODSCardTitleFirstModel(
            title: cardExampleTitle,
            subtitle: showSubtitle ? cardExampleSubtitle : nil,
            thumbnail: showThumbnail ? Image("ods_empty", bundle: Bundle.ods) : nil,
            image: Image("ods_empty", bundle: Bundle.ods),
            supportingText: showSupportingText ? cardExampleSupportingText : nil)
    }

    func displayAlert(text: String) {
        self.alertText = text
        self.showAlert = true
    }
}

struct CardTitleFirstVariant: View {

    @ObservedObject var model: CardTitleFirstVariantModel
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView {
                ODSCardTitleFirst(model: model.cardModel) {
                    if model.showButton1 {
                        ODSButton(text: "Button 1", emphasis: .highest) {
                            model.displayAlert(text: "Button 1 clicked")
                        }
                    }
                } buttonContent2: {
                    if model.showButton2 {
                        ODSButton(text: "Button 2", emphasis: .highest) {
                            model.displayAlert(text: "Button 2 clicked")
                        }
                    }
                }
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.m)
                .onTapGesture {
                    model.displayAlert(text: "Card container clicked")
                }
            }
            .alert(model.alertText, isPresented: $model.showAlert) {
                Button("close", role: .cancel) {}
            }

            BottomSheet(showContent: false) {
                CardTitleFirstBottomSheetContent()
            }
            .environmentObject(model)
        }
    }
}

struct CardTitleFirstBottomSheetContent: View {

    @EnvironmentObject var model: CardTitleFirstVariantModel

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Thumbnail", isOn: $model.showThumbnail)
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
