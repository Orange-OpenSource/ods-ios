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

extension ODSCardSideBySideModel.ImagePosition: CaseIterable {
    public static var allCases: [ODSCardSideBySideModel.ImagePosition] = [.left, .right]
    
    var description: String {
        switch self {
        case .left:
            return "Left"
        case .right:
            return "Right"
        }
    }
    
    var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

class CardSideBySideVariantModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showSubtitle: Bool
    @Published var showSupportingText: Bool
    @Published var buttonCount: Int
    @Published var showAlert: Bool
    @Published var imagePosition: ODSCardSideBySideModel.ImagePosition
    
    var alertText: String = ""
    private let buttonsText = ["Button 1", "Button 2"]
    private var recipe: Recipe {
        RecipeBook.shared.recipes[0]
    }
    
    // =================
    // MARK: Initializer
    // =================
    
    init() {
        showSubtitle = true
        showSupportingText = true
        imagePosition = .left
        buttonCount = 0
        showAlert = false
    }

    // =============
    // MARK: Helpers
    // =============

    var cardModel: ODSCardSideBySideModel {
        ODSCardSideBySideModel(
            title: recipe.title,
            subtitle: showSubtitle ? recipe.subtitle : nil,
            imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
            imagePosition: imagePosition,
            supportingText: showSupportingText ? recipe.description : nil)
    }

    func displayAlert(text: String) {
        self.alertText = text
        self.showAlert = true
    }
    
    var button1Text: String? {
        buttonCount >= 1 ? buttonsText[0] : nil
    }

    var button2Text: String? {
        buttonCount >= 2 ? buttonsText[1] : nil
    }

    var numberOfButtons: Int {
        buttonsText.count
    }
}

struct CardSideBySideVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: CardSideBySideVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            ScrollView {
                ODSCardSideBySide(model: model.cardModel) {
                    if let text = model.button1Text {
                        ODSButton(text: LocalizedStringKey(text), emphasis: .medium) {
                            model.displayAlert(text: "Button 1 clicked")
                        }
                    }
                } buttonContent2: {
                    if let text = model.button2Text {
                        ODSButton(text: LocalizedStringKey(text), emphasis: .medium) {
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
                CardSideBySideVariantOptions(model: model)
            }
        }
    }
}

private struct CardSideBySideVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: CardSideBySideVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Subtitle", isOn: $model.showSubtitle)
                .padding(.horizontal, ODSSpacing.m)
            Toggle("Text", isOn: $model.showSupportingText)
                .padding(.horizontal, ODSSpacing.m)
            
            ODSChipPicker(title: "Image position",
                          selection: $model.imagePosition,
                          chips: ODSCardSideBySideModel.ImagePosition.chips)
            
            Stepper("Number of buttons: \(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.numberOfButtons)
            .padding(.horizontal, ODSSpacing.m)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}