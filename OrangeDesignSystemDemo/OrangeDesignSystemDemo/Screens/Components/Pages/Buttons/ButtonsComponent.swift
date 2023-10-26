/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// ========================
// MARK: - Button Component
// ========================

struct ButtonComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = °°"screens.guidelines.buttons.title"
        imageName = "Buttons - Shape"
        description = °°"screens.guidelines.buttons.description"
        variants = AnyView(ButtonVariants())
    }
}

// =======================
// MARK: - Button Variants
// =======================

struct ButtonVariants: View {

    var body: some View {
        VariantEntryItem(title: °°"screens.guidelines.buttons.variant.emphasis", technicalElement: "ODSButton()") {
            CommonButtonVariant(model: EmphasisAndFunctionnalVariantModel()) { model in
                EmphasisVariant(model: model)
            }
            .navigationTitle("screens.guidelines.buttons.variant.emphasis")
        }
        
        VariantEntryItem(title: °°"screens.guidelines.buttons.variant.functional", technicalElement: "ODSFunctionalButton()") {
            
            CommonButtonVariant(model: EmphasisAndFunctionnalVariantModel()) { model in
                FunctionalVariant(model: model)
            }
            .navigationTitle("screens.guidelines.buttons.variant.functional")
        }
        
        VariantEntryItem(title: °°"screens.guidelines.buttons.variant.icons", technicalElement: "ODSIconButton()") {
            IconVariant(model: IconVariantModel())
                .navigationTitle("screens.guidelines.buttons.variant.icons")
        }
    }
}

// =============================
// MARK: - Common Button Variant
// =============================

struct CommonButtonVariant<Variant>: View where Variant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: EmphasisAndFunctionnalVariantModel
    let contentView: (_ model: EmphasisAndFunctionnalVariantModel) -> Variant

    // =================
    // MARK: Initializer
    // =================

    init(model: EmphasisAndFunctionnalVariantModel, @ViewBuilder contentView: @escaping (_ model: EmphasisAndFunctionnalVariantModel) -> Variant) {
        self.model = model
        self.contentView = contentView
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            ScrollView {
                VStack(spacing: ODSSpacing.m) {
                    contentView(model)
                }
                .padding(.top, ODSSpacing.m)
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.bottom, 55)
            .background(Color("componentBackground2"))
        } options: {
            EmphasisAndFunctionalVariantOptions(model: model)
        }        
    }
}
