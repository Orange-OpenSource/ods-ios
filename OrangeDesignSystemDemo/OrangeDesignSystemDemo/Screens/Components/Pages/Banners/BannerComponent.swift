/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

struct BannerComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "screens.guidelines.banners.title".🌐
        imageName = "Banners"
        description = "screens.guidelines.banners.description".🌐
        variants = AnyView(BannerVariants())
    }
}

struct BannerVariants: View {
    
    var body: some View {
        VariantEntryItem(title:"screens.guidelines.banners.variant.title_demo".🌐, technicalElement: "ODSBanner()") {
            BannerVariant(model: BannerVariantModel())
                .navigationTitle("screens.guidelines.banners.variant.title")
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
