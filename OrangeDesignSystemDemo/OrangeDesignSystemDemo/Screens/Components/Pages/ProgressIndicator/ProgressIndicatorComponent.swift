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
                .odsNavigationTitle("screens.components.progress_indicators.progress_bar.title".🌐)
        }

        VariantEntryItem(title: "screens.components.progress_indicators.activity_bar.title", technicalElement: "ProgressView()") {
            ActivityIndicatorVariant(model: ActivityIndicatorModel())
                .odsNavigationTitle("screens.components.progress_indicators.activity_bar.title".🌐)
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
