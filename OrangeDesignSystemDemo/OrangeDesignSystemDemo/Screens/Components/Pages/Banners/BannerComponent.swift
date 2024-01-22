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

struct BannerComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.banners.title"
        imageName = "Banners"
        description = °°"screens.components.banners.description"
        variants = AnyView(BannerVariants())
    }
}

struct BannerVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.banners.variant.title_demo", technicalElement: "ODSBanner()") {
            BannerVariant(model: BannerVariantModel())
                .navigationTitle("screens.components.banners.variant.title")
        }
    }
}

struct BannerVariant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            BannerVariantContent(model: model)
        } options: {
            BannerVariantOptions(model: model)
        }
    }
}

struct BannerVariantContent: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            switch model.buttonCount {
            case 0:
                ODSBanner(model.text, imageSource: model.imageSource)
            case 1:
                ODSBanner(model.text, imageSource: model.imageSource) {
                    Button(model.buttonText) {
                        // Do something
                    }
                }
            case 2:
                ODSBanner(model.text, imageSource: model.imageSource) {
                    Button(model.firstButtonText) {
                        // Do something
                    }
                } secondButton: {
                    Button(model.secondButtonText) {
                        // Do something
                    }
                }
            default:
                EmptyView()
            }

            Spacer()
        }
    }
}
