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
    @Published var showButton1: Bool
    @Published var showButton2: Bool

    // =================
    // MARK: Initializer
    // =================

    init() {
        self.showLongText = true
        self.showImage = true
        self.showButton1 = true
        self.showButton2 = true
    }
    
    // =============
    // MARK: Helpers
    // =============

    var text: LocalizedStringKey {
        let longText = "Two lines text string with two actions. One to two lines is preferable on mobile."
        let shortText = "One line text string with one action."
        
        return LocalizedStringKey(showLongText ? longText : shortText)
    }
    
    var image: Image? {
        showImage ? Image("ods_empty", bundle: Bundle.ods) : nil
    }
    
    var button1: ODSButton? {
        showButton1 ? ODSButton(text: "Button 1", emphasis: .low) {
            // do something
        } : nil
    }
    
    var button2: ODSButton? {
        showButton2 ? ODSButton(text: "Button 2", emphasis: .low) {
            // do something
        } : nil
    }
}

struct BannerBottomSheet: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject var model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Long Text", isOn: $model.showLongText)
            Toggle("Image", isOn: $model.showImage)
            Toggle("Button 1", isOn: $model.showButton1)
            Toggle("Button 2", isOn: $model.showButton2)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
