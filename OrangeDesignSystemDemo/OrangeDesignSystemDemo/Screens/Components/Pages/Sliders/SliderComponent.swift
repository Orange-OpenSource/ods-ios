//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct SliderComponent: Component {
    let title: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        title = °°"screens.guidelines.sliders.title"
        imageName = "Slider"
        description = °°"screens.guidelines.sliders.description"
        variants = AnyView(SliderVariants())
    }
}

struct SliderVariants: View {

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VariantEntryItem(title: °°"screens.guidelines.sliders.slider.title", technicalElement: "ODSSlider()") {
            SliderVariant(model: SliderVariantModel())
                .navigationTitle("screens.guidelines.sliders.slider.title")
        }
    }
}

#if DEBUG
struct SliderComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    SliderVariants()
                }
            }
        }
    }
}
#endif
