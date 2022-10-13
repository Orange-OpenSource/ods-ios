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

class SmallCardVariantModel: ObservableObject {
    @Published var showSubtitle: Bool
    
    var smallCardModels: [ODSSmallCardModel] {
        [
            ODSSmallCardModel(title: "Title",
                              subtitle: showSubtitle ? "Subtitle" : nil,
                              image: Image("ods_empty", bundle: Bundle.ods))
        ]
    }
    
    init() {
        showSubtitle = true
    }
}

struct SmallCardVariant: View {
    @ObservedObject var model: SmallCardVariantModel
    
    let columns = [
        GridItem(.adaptive(minimum: 150.0), spacing: ODSSpacing.none, alignment: .topLeading),
        GridItem(.flexible(minimum: 50.0))
    ]

    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: ODSSpacing.none) {
                    ForEach(model.smallCardModels) { model in
                        ODSSmallCard(model: model)
                    }
                }
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.top, ODSSpacing.m)
            
            BottomSheet {
                SmallCardBottomSheetContent()
            }
            .environmentObject(model)
        }
        .navigationTitle("Small card")
    }
}

// MARK: Bottom Sheet content
struct SmallCardBottomSheetContent: View {

    @EnvironmentObject var model: SmallCardVariantModel

    var body: some View {
        Toggle("Subtitle", isOn: $model.showSubtitle)
            .odsFont(.bodyRegular)
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.m)
    }
}

#if DEBUG
struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SmallCardVariant(model: SmallCardVariantModel())
        }
    }
}
#endif
