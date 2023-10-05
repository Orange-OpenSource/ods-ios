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

class CardVerticalHeaderFirstVariantModel: ObservableObject {
    
    // =======================
    // MARK: Stored properties
    // =======================

    @Published var showThumbnail: Bool
    @Published var showSubtitle: Bool
    @Published var showText: Bool
    @Published var buttonCount: Int
    @Published var showAlert: Bool
    
    var alertText: String = ""
    let buttonsText = ["Button 1", "Button 2"]
    private var recipe: Recipe {
        RecipeBook.shared.recipes[0]
    }

    // =================
    // MARK: Initializer
    // =================

    init() {
        showThumbnail = true
        showSubtitle = true
        showText = true
        buttonCount = 2
        showAlert = false
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
    
    var thumbnail: Image? {
        showThumbnail ? Image("ods_empty", bundle: Bundle.ods) : nil
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
}

struct CardVerticalHeaderFirstVariant: View {
    
    // =======================
    // MARK: Stored properties
    // =======================
    
    @ObservedObject var model: CardVerticalHeaderFirstVariantModel
    
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
            CardVerticalHeaderFirstVariantOptions(model: model)
        }
    }
    
    @ViewBuilder
    private var card: some View {
        switch model.buttonCount {
        case 0:
            ODSCardVerticalHeaderFirst(title: model.title,
                                       imageSource: model.imageSource,
                                       subtitle: model.subtitle,
                                       thumbnail: model.thumbnail,
                                       text: model.text)
        case 1:
            ODSCardVerticalHeaderFirst(
                title: model.title,
                imageSource: model.imageSource,
                subtitle: model.subtitle,
                thumbnail: model.thumbnail,
                text: model.text
            ) {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "\(model.firstButtonText) clicked")
                }
            }
        case 2:
            ODSCardVerticalHeaderFirst(
                title: model.title,
                imageSource: model.imageSource,
                subtitle: model.subtitle,
                thumbnail: model.thumbnail,
                text: model.text
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

private struct CardVerticalHeaderFirstVariantOptions: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: CardVerticalHeaderFirstVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Thumbnail", isOn: $model.showThumbnail)
            Toggle("Subtitle", isOn: $model.showSubtitle)
            Toggle("Text", isOn: $model.showText)
            
            Stepper("Number of buttons: \(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.buttonsText.count)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
