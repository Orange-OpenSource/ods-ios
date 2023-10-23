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

import OrangeDesignSystem
import SwiftUI

struct ComponentPage: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let component: Component
    @EnvironmentObject private var themeProvider: ThemeProvider
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        List {
            VStack {
                themeProvider.imageFromResources(component.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: ODSSpacing.m) {
                    ComponentDescription(text: component.description)

                    VariantsTitle()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ODSSpacing.m)
                .padding(.bottom, ODSSpacing.m)
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, ODSSpacing.none)
            
            component.variants
        }
        .listRowSeparator(Visibility.hidden)
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.horizontal, ODSSpacing.none)
        .navigationTitle(component.title)
        .navigationbarMenuForThemeSelection()
    }
}

private struct ComponentDescription: View {
    let text: String
    var body: some View {
        Text(text)
            .odsFont(.bodyRegular)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, ODSSpacing.xs)
    }
}

struct VariantsTitle: View {
    var body: some View {
        Text("Variants")
            .odsFont(.title1)
            .accessibilityAddTraits(.isHeader)
    }
}

struct VariantEntryItem<VariantPage>: View where VariantPage: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================
    
    private let title: Text
    private let technicalElement: Text
    private let showThemeSelectionInNavigationBar: Bool
    private let variantPage: () -> VariantPage
    
    // =================
    // MARK: Initializer
    // =================

    init(
        title: String,
        technicalElement: String,
        showThemeSelectionInNavigationBar: Bool = true,
        @ViewBuilder variantPage: @escaping () -> VariantPage
    ) {
        self.title = Text(title)
        self.technicalElement = Text(technicalElement)
        self.showThemeSelectionInNavigationBar = showThemeSelectionInNavigationBar
        self.variantPage = variantPage
    }

    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        NavigationLink {
            if showThemeSelectionInNavigationBar {
                variantPage().navigationbarMenuForThemeSelection()
            } else {
                variantPage()
            }
        } label: {
            ODSListItem(title: title, subtitle: technicalElement, leading: .icon(Image(systemName: "play.circle")))
        }
        .odsListItemStyle(showSeparator: false)
    }
}

#if DEBUG
struct ComponentPage_Previews: PreviewProvider {
    struct TestComponent: Component {
        let title: String
        let imageName: String
        let description: String
        let variants: AnyView
        
        init() {
            title = "Test"
            imageName = "Cards_1"
            description = "This is a long text to illustrate the description area"
            
            variants = AnyView(Variants())
        }
    }

    struct Variants: View {
        var body: some View {
            VariantEntryItem(title: "Variant 1", technicalElement: "MyTestElement()") {
                Text("This is a Variant")
            }
        }
    }
    
    static var previews: some View {
        VStack{
            ComponentPage(component: TestComponent())
        }
    }

}
#endif
