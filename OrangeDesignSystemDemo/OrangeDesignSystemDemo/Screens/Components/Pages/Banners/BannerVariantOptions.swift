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

final class BannerVariantModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    @Published var showLongText: Bool
    @Published var showImage: Bool
    @Published var buttonCount: Int
    @Published var recipe: Recipe
    
    let buttonsText = [°°"shared.actions.action_1",
                       °°"shared.actions.action_2"]

    // =================
    // MARK: Initializer
    // =================

    init() {
        showLongText = true
        showImage = true
        buttonCount = 0
        
        self.recipe = RecipeBook.shared.recipes[0]
    }
    
    // =============
    // MARK: Helpers
    // =============

    var text: Text {
        Text(showLongText ? recipe.description :  recipe.title)
    }

    var imageSource: ODSImage.Source? {
        let placeholder = Image("placeholder", bundle: Bundle.ods)
        return showImage ? .asyncImage(recipe.url, placeholder) : nil
    }

    var buttonText: String {
        "shared.actions.action".🌐
    }

    var firstButtonText: String {
        buttonsText[0]
    }

    var secondButtonText: String {
        buttonsText[1]
    }
    
    func updateRecipe() {
        recipe = RecipeBook.shared.randomRecipe()
    }
}

struct BannerVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("shared.long_text", isOn: $model.showLongText)
            Toggle("screens.components.banners.demo.toggle_image_hint", isOn: $model.showImage)
            Stepper("screens.components.banners.demo.buttons_number_hint" <- "\(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.buttonsText.count)
        }
        .odsFont(.bodyLRegular)
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.m)
    }
}
