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

import SwiftUI
import OrangeDesignSystem

struct ListOfVerticalImageFirstCard: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let columns = [GridItem(.flexible(), alignment: .topLeading)]

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: ODSSpacing.xs) {
                ForEach(RecipeBook.shared.recipes, id: \.id) { recipe in
                    NavigationLink {
                        Text("Bon appétit")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationbarMenuForThemeSelection()
                    } label: {
                        ODSCardVerticalImageFirst(
                            title: Text(recipe.title),
                            imageSource: .asyncImage(recipe.url, Image("ods_empty", bundle: Bundle.ods)),
                            subtitle: Text(recipe.subtitle),
                            text: Text(recipe.description)
                        )
                    }
                }
            }
            .padding(.all, ODSSpacing.m)
        }
    }
}

#if DEBUG
struct ListOfVerticalImageFirstCard_Previews: PreviewProvider {
    static var previews: some View {
        ListOfVerticalImageFirstCard()
                .previewInterfaceOrientation(.portrait)
        
        ListOfVerticalImageFirstCard()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3)
        
        ListOfVerticalImageFirstCard()
                .previewInterfaceOrientation(.landscapeRight)
    }
}
#endif

