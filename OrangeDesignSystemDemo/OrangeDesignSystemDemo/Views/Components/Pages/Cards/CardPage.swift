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

struct CardComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Cards"
        image = Image("Cards_1")
        description = "Cards are a contained and independent element that can display content and actions on a single topic."
        
        variants = AnyView(CardVariants())
    }
}


struct CardVariants: View {
    
    var body: some View {
        VariantEntryItem(text: "Card Image First", technicalElement: "ODSCardImageFirst()") {
            CardImageFirstVariant(model: CardImageFirstVariantModel())
                .navigationTitle("Card Image First")
        }
        
        VariantEntryItem(text: "Card Title First", technicalElement: "ODSCardTitleFirst()") {
            CardTitleFirstVariant(model: CardTitleFirstVariantModel())
                .navigationTitle("Card Title First")
        }

        VariantEntryItem(text: "Small card", technicalElement: "ODSSmallCard") {
            SmallCardVariant(model: SmallCardVariantModel())
                .navigationTitle("Small card")
        }
    }
}

#if DEBUG
struct CardViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardVariants()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            CardVariants()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
