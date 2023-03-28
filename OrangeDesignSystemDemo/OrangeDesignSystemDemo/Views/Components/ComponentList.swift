//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import Foundation
import OrangeDesignSystem
import SwiftUI

struct ComponentsList: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    let components: [Component]
    let columns = [
        GridItem(.adaptive(minimum: 150), spacing: ODSSpacing.m, alignment: .topLeading),
    ]

    @EnvironmentObject var themeProvider: ThemeProvider

    // =================
    // MARK: Initializer
    // =================

    init() {
        // Remark: Components are automatically displayed sorted by their name
        let components: [Component] = [
            BannerComponent(),
            ButtonComponent(),
            CardComponent(),
            ChipsComponent(),
            ListComponent(),
            NavigationBarComponent(),
            ProgressIndicatorComponent(),
            SliderComponent(),
            TabBarComponent(),
            ToolBarComponent(),
            TextFieldComponent(),
        ]
        
        self.components = components.sorted { $0.title < $1.title }
    }
    
    // =====================
    // MARK: Computed values
    // =====================
    
    private var sortedComponentCardModels: [ODSCardSmallModel] {
        components.map { smallCardModel(for: $0) }
    }
    
    private func smallCardModel(for component: Component) -> ODSCardSmallModel {
        let image = themeProvider.imageFromResources(component.imageName)
        
        return ODSCardSmallModel(title: component.title, imageSource: .image(image)) {
            ComponentPage(component: component)
        }
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ScrollView {
                ODSGridOfCards(cardModels: sortedComponentCardModels)
                    .padding(.vertical, ODSSpacing.m)
                    .padding(.horizontal, ODSSpacing.s)
            }
            .navigationTitle("Components")
            .navigationbarMenuForThemeSelection()
            
            ComponentPage(component: components[0])
        }
    }
}

#if DEBUG
import OrangeTheme

struct ComponentsCardsList_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            ComponentsList()
        }
    }
}
#endif
