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

struct SliderComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.sliders.title"
        imageName = "Slider"
        description = °°"screens.components.sliders.description"
        variants = AnyView(SliderVariants())
    }
}

struct SliderVariants: View {

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VariantEntryItem(title: "screens.components.sliders.slider.title", technicalElement: "ODSSlider()") {
            SliderVariant(model: SliderVariantModel())
                .navigationTitle("screens.components.sliders.slider.title")
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
