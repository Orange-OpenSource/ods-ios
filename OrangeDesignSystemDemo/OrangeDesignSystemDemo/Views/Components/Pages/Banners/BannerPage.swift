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

struct BannerComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Banners Demo"
        image = Image("Buttons - Shape")
        description = "A banner displays an important message which requires an action to be dismissed."
        
        variants = AnyView(BannerVariants())
    }
}

struct BannerVariants: View {
    
    var body: some View {
        VariantEntryItem(text: "Banner", technicalElement: "ODSBanner()") {
            BannerVariant(model: BannerVariantModel())
                .navigationTitle("Banner")
        }
    }
}

struct BannerVariant: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    let model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            BannerVariantInnner(model: model)
            BottomSheet {
                BannerBottomSheet()
            }
            .environmentObject(model)
        }
    }
}
        
struct BannerVariantInnner: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        VStack {
            ODSBanner(text: "Two line text string with two actions. One to two lines is preferable on mobile and tablet.",
                      image: model.image,
                      button1: model.button1,
                      button2: model.button2)
            
            Spacer()
        }
    }
}
