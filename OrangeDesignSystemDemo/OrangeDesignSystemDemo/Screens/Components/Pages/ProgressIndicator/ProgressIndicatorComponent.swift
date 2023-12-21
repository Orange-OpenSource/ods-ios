//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct ProgressIndicatorComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.progress_indicators.title"
        imageName = "Progress indicator"
        description = °°"screens.components.progress_indicators.description"
        variants = AnyView(ProgressIndicatorVariants())
    }
}

private struct ProgressIndicatorVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.progress_indicators.progress_bar.title", technicalElement: "ProgressView(value:, total:)") {
            ProgressBarVariant(model: ProgressBarVariantModel())
                .navigationTitle("screens.components.progress_indicators.progress_bar.title")
        }

        VariantEntryItem(title: "screens.components.progress_indicators.activity_bar.title", technicalElement: "ProgressView()") {
            ActivityIndicatorVariant(model: ActivityIndicatorModel())
                .navigationTitle("screens.components.progress_indicators.activity_bar.title")
        }
    }
}

#if DEBUG
struct ProgressIndicatorComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    ProgressIndicatorVariants()
                }
            }
        }
    }
}
#endif
