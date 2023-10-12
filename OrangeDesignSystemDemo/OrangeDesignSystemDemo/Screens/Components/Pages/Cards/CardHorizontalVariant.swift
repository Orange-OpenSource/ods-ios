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

extension ODSCardHorizontal.ImagePosition: CaseIterable {

    public static var allCases: [ODSCardHorizontal.ImagePosition] = [.leading, .trailing]
    
    var description: String {
        switch self {
        case .leading:
            return "Start"
        case .trailing:
            return "End"
        }
    }
    
    var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

class CardHorizontalVariantModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showSubtitle: Bool
    @Published var showText: Bool
    @Published var buttonCount: Int
    @Published var showAlert: Bool
    @Published var imagePosition: ODSCardHorizontal.ImagePosition
    @Published var showDivider: Bool
    
    var alertText: String = ""
    let buttonsText: [String]
    private let recipe: Recipe
    
    // =================
    // MARK: Initializer
    // =================
    
    init() {
        showSubtitle = true
        showText = true
        imagePosition = .leading
        buttonCount = 0
        showAlert = false
        showDivider = true
        
        buttonsText = ["Button 1", "Button 2"]
        recipe = RecipeBook.shared.recipes[0]
    }

    // ==================
    // MARK: Card Content
    // ==================
    
    var title: Text {
        Text(recipe.title)
    }
    
    var subtitle: Text? {
        showSubtitle ? Text(recipe.subtitle) : nil
    }
    
    var imageSource: ODSImage.Source {
        .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods))
    }
    
    var text: Text? {
        showText ? Text(recipe.description) : nil
    }
    
    var firstButtonText: String {
        buttonsText[0]
    }

    var secondButtonText: String  {
        buttonsText[1]
    }

    func displayAlert(text: String) {
        self.alertText = text
        self.showAlert = true
    }
    
    var numberOfButtons: Int {
        buttonsText.count
    }
}

struct CardHorizontalVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: CardHorizontalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ScrollView {
                card
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.top, ODSSpacing.m)
                    .onTapGesture {
                        model.displayAlert(text: "Card container clicked")
                    }
            }
            .alert(model.alertText, isPresented: $model.showAlert) {
                Button("close", role: .cancel) {}
            }
        } options: {
            CardHorizontalVariantOptions(model: model)
        }
    }
    
    @ViewBuilder
    private var card: some View {
        switch model.buttonCount {
        case 0:
            ODSCardHorizontal(title: model.title,
                              imageSource: model.imageSource,
                              imagePosition: model.imagePosition,
                              subtitle: model.subtitle,
                              text: model.text)
        case 1:
            ODSCardHorizontal(
                title: model.title,
                imageSource: model.imageSource,
                imagePosition: model.imagePosition,
                subtitle: model.subtitle,
                text: model.text,
                dividerEnabled: model.showDivider
            ) {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "\(model.firstButtonText) clicked")
                }
            }
        case 2:
            ODSCardHorizontal(
                title: model.title,
                imageSource: model.imageSource,
                imagePosition: model.imagePosition,
                subtitle: model.subtitle,
                text: model.text,
                dividerEnabled: model.showDivider
            ) {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "\(model.firstButtonText) clicked")
                }
            } secondButton: {
                Button(model.secondButtonText) {
                    model.displayAlert(text: "\(model.secondButtonText) clicked")
                }
            }
            
        default:
            EmptyView()
        }
    }
}

private struct CardHorizontalVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: CardHorizontalVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Subtitle", isOn: $model.showSubtitle)
                .padding(.horizontal, ODSSpacing.m)
            Toggle("Text", isOn: $model.showText)
                .padding(.horizontal, ODSSpacing.m)
            
            ODSChipPicker(title: "Image position",
                          selection: $model.imagePosition,
                          chips: ODSCardHorizontal.ImagePosition.chips)
            
            Toggle("Divider", isOn: $model.showDivider)
                .padding(.horizontal, ODSSpacing.m)

            Stepper("Number of buttons: \(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.buttonsText.count)
            .padding(.horizontal, ODSSpacing.m)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}
