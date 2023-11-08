//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

// ================================================
// MARK: - Card Vertical Header First Variant Model
// ================================================

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
    let buttonsText: [String]
    private let recipe: Recipe

    // =================
    // MARK: Initializer
    // =================

    init() {
        showThumbnail = true
        showSubtitle = true
        showText = true
        buttonCount = 2
        showAlert = false

        buttonsText = [°°"screens.components.card.button_1",
                       °°"screens.components.card.button_2"]
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

    var secondButtonText: String {
        buttonsText[1]
    }

    func displayAlert(text: String) {
        alertText = text
        showAlert = true
    }
}

// ==========================================
// MARK: - Card Vertical Header First Variant
// ==========================================

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
                        model.displayAlert(text: "screens.components.card.alert")
                    }
            }
            .alert(model.alertText, isPresented: $model.showAlert) {
                Button("shared.close", role: .cancel) {}
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
                text: model.text)
            {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "screens.components.card.alert_2" <- "\(model.firstButtonText)")
                }
            }
        case 2:
            ODSCardVerticalHeaderFirst(
                title: model.title,
                imageSource: model.imageSource,
                subtitle: model.subtitle,
                thumbnail: model.thumbnail,
                text: model.text)
            {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "screens.components.card.alert_2" <- "\(model.firstButtonText)")
                }
            } secondButton: {
                Button(model.secondButtonText) {
                    model.displayAlert(text: "screens.components.card.alert_2" <- "\(model.secondButtonText)")
                }
            }

        default:
            EmptyView()
        }
    }
}

// ==================================================
// MARK: - Card Vertical Header First Variant Options
// ==================================================

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
            Toggle("screens.components.card.thumbnail", isOn: $model.showThumbnail)
            Toggle("shared.subtitle", isOn: $model.showSubtitle)
            Toggle("shared.text", isOn: $model.showText)

            Stepper("screens.components.card.buttons_number" <- "\(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.buttonsText.count)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
