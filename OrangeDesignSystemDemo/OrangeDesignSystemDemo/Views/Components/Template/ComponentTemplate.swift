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

struct ComponentDescription: View {
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

struct ComponentPage<VariantEntries>: View where VariantEntries: View {
    let imageName: String
    let componentDescription: String
    let variants: () -> VariantEntries

    var body: some View {
        List {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: ODSSpacing.m) {
                    ComponentDescription(text: componentDescription)

                    VariantsTitle()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ODSSpacing.m)
                .padding(.bottom, ODSSpacing.m)
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, ODSSpacing.none)
            
            variants()
                .listRowInsets(EdgeInsets())
                .listRowSeparator(Visibility.hidden)
                .padding(.horizontal, ODSSpacing.m)
        }
        .listRowSeparator(Visibility.hidden)
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.bottom, ODSSpacing.m)
        .background(ODSColor.componentBackground2.color)
    }
}

struct VariantEntyItem<VariantPage>: View where VariantPage: View {
    let itemModel: ODSListItemModel
    let variantPage: () -> VariantPage
    
    var body: some View {
        NavigationLink(itemModel) {
            variantPage()
        }
    }
    
    init(text: String, technicalElement: String, variantPage: @escaping () -> VariantPage) {
        self.itemModel = ODSListItemModel(title: text, subtitle: technicalElement)
        self.variantPage = variantPage
    }
}

#if DEBUG
struct ComponentPage_Previews: PreviewProvider {
    
    struct Variants: View {
        var body: some View {
            VariantEntyItem(text: "Single Selection", technicalElement: "ODSChipPicker") {
                Text("This is a Variant")
            }
        }
    }
    static var previews: some View {
        VStack{
            ComponentPage(imageName: "Chips", componentDescription: "Chips are small components containing a number of elements that represent a calendar event or contact.") {
                
                   Variants()
            }
        }
    }

}
#endif
