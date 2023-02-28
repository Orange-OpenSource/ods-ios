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
    let component: Component
    
    var body: some View {
        List {
            VStack {
                component.image
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
                .listRowInsets(EdgeInsets())
                .listRowSeparator(Visibility.hidden)
                .padding(.horizontal, ODSSpacing.m)
        }
        .listRowSeparator(Visibility.hidden)
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.horizontal, ODSSpacing.none)
        .padding(.bottom, ODSSpacing.m)
        .navigationTitle(component.title)
        .navigationViewStyle(.stack)
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

    private let itemModel: ODSListStandardItemModel
    private let variantPage: () -> VariantPage
    private let showThemeSelectionInNavigationBar: Bool
    
    var body: some View {
        NavigationLink(itemModel) {
            if showThemeSelectionInNavigationBar {
                variantPage().navigationbarMenuForThemeSelection()
            } else {
                variantPage()
            }
        }
    }
    
    init(text: String, technicalElement: String,
         showThemeSelectionInNavigationBar: Bool = true,
         @ViewBuilder variantPage: @escaping () -> VariantPage) {
        
        self.showThemeSelectionInNavigationBar = showThemeSelectionInNavigationBar
        let playIcon = ODSListItemLeadingIcon.icon(Image(systemName: "play.circle"))
        self.itemModel = ODSListStandardItemModel(title: text,
                                                  subtitle: technicalElement,
                                                  leadingIcon: playIcon)
        self.variantPage = variantPage
    }
}

#if DEBUG
struct ComponentPage_Previews: PreviewProvider {
    struct TestComponent: Component {
        let title: String
        let image: Image
        let description: String
        let variants: AnyView
        
        init() {
            title = "Test"
            image = Image("Cards_1")
            description = "This is a long text to illustrate the description area"
            
            variants = AnyView(Variants())
        }
    }

    struct Variants: View {
        var body: some View {
            VariantEntryItem(text: "Variant 1", technicalElement: "MyTestElement()") {
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
