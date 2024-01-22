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

// ========================
// MARK: - Button Component
// ========================

struct ButtonComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.buttons.title"
        imageName = "Buttons - Shape"
        description = °°"screens.components.buttons.description"
        variants = AnyView(ButtonVariants())
    }
}

// =======================
// MARK: - Button Variants
// =======================

struct ButtonVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.buttons.variant.emphasis", technicalElement: "ODSButton()") {
            CommonButtonVariant(model: EmphasisAndFunctionnalVariantModel()) { model in
                EmphasisVariant(model: model)
            }
            .navigationTitle("screens.components.buttons.variant.emphasis")
        }

        VariantEntryItem(title: "screens.components.buttons.variant.functional", technicalElement: "ODSFunctionalButton()") {

            CommonButtonVariant(model: EmphasisAndFunctionnalVariantModel()) { model in
                FunctionalVariant(model: model)
            }
            .navigationTitle("screens.components.buttons.variant.functional")
        }

        VariantEntryItem(title: "screens.components.buttons.variant.icons", technicalElement: "ODSIconButton()") {
            IconVariant(model: IconVariantModel())
                .navigationTitle("screens.components.buttons.variant.icons")
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
