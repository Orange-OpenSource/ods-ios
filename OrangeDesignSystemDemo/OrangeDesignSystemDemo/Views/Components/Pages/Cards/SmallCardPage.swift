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

struct SmallCardPage: View {
    let columns = [
        GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .topLeading),
    ]

    let gridModel = [
        ODSSmallCardModel(title: "1 Title", image: Image("ods_empty", bundle: Bundle.ods)),
        ODSSmallCardModel(title: "2 Title", subtitle: "2 Subtitle", image: Image("ods_empty", bundle: Bundle.ods)),
        ODSSmallCardModel(title: "3 A long long title", subtitle: "3 A long long Subtitle", image: Image("ods_empty", bundle: Bundle.ods)),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: ODSSpacing.none) {
                ForEach(gridModel) { model in
                    ODSSmallCard(model: model)
                }
            }
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.top, ODSSpacing.m)
        .navigationTitle("Small card")
    }
}
