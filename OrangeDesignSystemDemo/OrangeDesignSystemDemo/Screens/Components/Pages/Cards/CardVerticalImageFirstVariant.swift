//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import OrangeDesignSystem
import SwiftUI

// ===============================================
// MARK: - Card Vertical Image First Variant Model
// ===============================================

final class CardVerticalImageFirstVariantModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showSubtitle: Bool
    @Published var showText: Bool
    @Published var buttonCount: Int
    @Published var showAlert: Bool
    @Published var recipe: Recipe

    var alertText: String = ""
    private let buttonsText: [String]

    // =================
    // MARK: Initializer
    // =================

    init() {
        showSubtitle = true
        showText = true
        buttonCount = 2
        showAlert = false

        buttonsText = ["screens.components.card.button_1".🌐,
                       "screens.components.card.button_2".🌐]
        recipe = RecipeBook.shared.recipes[0]
    }

    // =============
    // MARK: Helpers
    // =============

    var title: Text {
        Text(recipe.title)
    }

    var subtitle: Text? {
        showSubtitle ? Text(recipe.subtitle) : nil
    }

    var imageSource: ODSImage.Source {
        .asyncImage(recipe.url, Image("placeholder", bundle: Bundle.ods))
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

    var numberOfButtons: Int {
        buttonsText.count
    }

    func updateRecipe() {
        recipe = RecipeBook.shared.randomRecipe()
    }
}

// =========================================
// MARK: - Card Vertical Image First Variant
// =========================================

struct CardVerticalImageFirstVariant: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @ObservedObject var model: CardVerticalImageFirstVariantModel

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
            .refreshable {
                model.updateRecipe()
            }
            .alert(model.alertText, isPresented: $model.showAlert) {
                Button("shared.close", role: .cancel) {}
            }
        } options: {
            CardVerticalImageFirstVariantOptions(model: model)
        }
    }

    // ===================
    // MARK: Pivate Helper
    // ===================

    @ViewBuilder
    private var card: some View {
        switch model.buttonCount {
        case 0:
            ODSCardVerticalImageFirst(
                title: model.title,
                imageSource: model.imageSource,
                subtitle: model.subtitle,
                text: model.text)
        case 1:
            ODSCardVerticalImageFirst(
                title: model.title,
                imageSource: model.imageSource,
                subtitle: model.subtitle,
                text: model.text)
            {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "screens.components.card.alert_2" <- "\(model.firstButtonText)")
                }
            }
        case 2:
            ODSCardVerticalImageFirst(
                title: model.title,
                imageSource: model.imageSource,
                subtitle: model.subtitle,
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

// =================================================
// MARK: - Card Vertical Image First Variant Options
// =================================================

private struct CardVerticalImageFirstVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: CardVerticalImageFirstVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("shared.subtitle", isOn: $model.showSubtitle)
            Toggle("shared.text", isOn: $model.showText)

            Stepper("screens.components.card.buttons_number" <- "\(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.numberOfButtons)
        }
        .odsFont(.bodyLRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
