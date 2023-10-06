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

class BannerVariantModel: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================
    
    @Published var showLongText: Bool
    @Published var showImage: Bool
    @Published var buttonCount: Int
    
    let buttonsText = ["Action 1", "Action 2"]

    // =================
    // MARK: Initializer
    // =================

    init() {
        self.showLongText = true
        self.showImage = true
        self.buttonCount = 0
    }
    
    // =============
    // MARK: Helpers
    // =============

    var text: Text {
        let longText = "Text could be on several lines. But, One to two lines is preferable on mobile."
        let shortText = "Short text"
        
        return Text(showLongText ? longText : shortText)
    }
    
    var imageSource: ODSImage.Source? {
        let placeholder = Image("ods_empty", bundle: Bundle.ods)
        
        if let url = RecipeBook.shared.recipes.first?.url {
            return showImage ? .asyncImage(url, placeholder) : nil
        } else {
            return showImage ? .image(placeholder) : nil
        }
    }
    
    var buttonText: String {
        "Action"
    }
    
    var firstButtonText: String {
        buttonsText[0]
    }
    
    var secondButtonText: String  {
        buttonsText[1]
    }
    
    var numberOfButtons: Int {
        buttonsText.count
    }
}

struct BannerVariantOptions: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Long Text", isOn: $model.showLongText)
            Toggle("Image", isOn: $model.showImage)
            Stepper("Number of buttons: \(model.buttonCount)",
                    value: $model.buttonCount,
                    in: 0 ... model.buttonsText.count)
        }
        .odsFont(.bodyRegular)
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.m)
    }
}
