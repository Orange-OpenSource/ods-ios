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

// =======================================
// MARK: - ODSCardHorizontal.ImagePosition
// =======================================

extension ODSCardHorizontal.ImagePosition: @retroactive CaseIterable {

    public static var allCases: [ODSCardHorizontal.ImagePosition] = [.leading, .trailing]

    var description: LocalizedStringKey {
        switch self {
        case .leading:
            return "shared.leading"
        case .trailing:
            return "shared.trailing"
        }
    }

    var chip: ODSChoiceChip<Self> {
        .init(text: Text(description), value: self)
    }

    static var chips: [ODSChoiceChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

// =====================================
// MARK: - Card Horizontal Variant Model
// =====================================

final class CardHorizontalVariantModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showSubtitle: Bool
    @Published var showText: Bool
    @Published var buttonCount: Int
    @Published var showAlert: Bool
    @Published var imagePosition: ODSCardHorizontal.ImagePosition
    @Published var showDivider: Bool
    @Published var recipe: Recipe

    var alertText: String
    let buttonsText: [String]
    

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
        alertText = ""
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

    func updateRecipe() {
        recipe = RecipeBook.shared.randomRecipe()
    }
}

// ===============================
// MARK: - Card Horizontal Variant
// ===============================

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
                dividerEnabled: model.showDivider)
            {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "screens.components.card.alert_2" <- "\(model.firstButtonText)")
                }
            }
        case 2:
            ODSCardHorizontal(
                title: model.title,
                imageSource: model.imageSource,
                imagePosition: model.imagePosition,
                subtitle: model.subtitle,
                text: model.text,
                dividerEnabled: model.showDivider)
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

// =======================================
// MARK: - Card Horizontal Variant Options
// =======================================

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
            Toggle("shared.subtitle", isOn: $model.showSubtitle)
                .padding(.horizontal, ODSSpacing.m)
            Toggle("shared.text", isOn: $model.showText)
                .padding(.horizontal, ODSSpacing.m)

            ODSChoiceChipPicker(
                title: Text("screens.components.card.picker.position"),
                chips: ODSCardHorizontal.ImagePosition.chips,
                selection: $model.imagePosition)

            Toggle("screens.components.card.divider", isOn: $model.showDivider)
                .padding(.horizontal, ODSSpacing.m)

            Stepper("screens.components.card.buttons_number" <- "\(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.buttonsText.count)
                .padding(.horizontal, ODSSpacing.m)
        }
        .odsFont(.bodyLRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}
