/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// =======================================
// MARK: - ODSCardHorizontal.ImagePosition
// =======================================

extension ODSCardHorizontal.ImagePosition: CaseIterable {

    public static var allCases: [ODSCardHorizontal.ImagePosition] = [.leading, .trailing]
    
    var description: String {
        switch self {
        case .leading:
            return "shared.leading".🌐
        case .trailing:
            return "shared.trailing".🌐
        }
    }
    
    var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

// =====================================
// MARK: - Card Horizontal Variant Model
// =====================================

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
    
    var alertText: String
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
        alertText = ""
        buttonsText = ["screens.guidelines.card.button_1".🌐,
                       "screens.guidelines.card.button_2".🌐]
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
                        model.displayAlert(text: "screens.guidelines.card.alert")
                    }
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
                dividerEnabled: model.showDivider
            ) {
                Button(model.firstButtonText) {
                    model.displayAlert(text: "screens.guidelines.card.alert_2".localized(with: ["\(model.firstButtonText)"]))
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
                    model.displayAlert(text: "screens.guidelines.card.alert_2".localized(with: ["\(model.firstButtonText)"]))
                }
            } secondButton: {
                Button(model.secondButtonText) {
                    model.displayAlert(text: "screens.guidelines.card.alert_2".localized(with: ["\(model.secondButtonText)"]))
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
            
            ODSChipPicker(title: "screens.guidelines.card.picker.position".🌐,
                          selection: $model.imagePosition,
                          chips: ODSCardHorizontal.ImagePosition.chips)
            
            Toggle("screens.guidelines.card.divider", isOn: $model.showDivider)
                .padding(.horizontal, ODSSpacing.m)

            Stepper("screens.guidelines.card.buttons_number".localized(with: ["\(model.buttonCount)"]),
                    value: $model.buttonCount,
                    in: 0 ... model.buttonsText.count)
            .padding(.horizontal, ODSSpacing.m)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}
