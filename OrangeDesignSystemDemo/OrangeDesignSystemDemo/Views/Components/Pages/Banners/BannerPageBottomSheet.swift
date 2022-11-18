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
    @Published var buttonsOption: ButtonsOption
    
    enum ButtonsOption: Int, CaseIterable {
        case none = 0
        case oneButtonNextToText
        case oneButtonUnderText
        case twoButtons
        
        var description: String {
            switch self {
            case .none:
                return "None"
            case .oneButtonNextToText:
                return "One next to text"
            case .oneButtonUnderText:
                return "One under text"
            case .twoButtons:
                return "Two"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }

    // =================
    // MARK: Initializer
    // =================

    init() {
        self.showLongText = true
        self.showImage = true
        self.buttonsOption = .none
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
    
    var button: ODSButton {
        ODSButton(text: "Button", emphasis: .low) {
            // do something
        }
    }
    
    var trailingButton: ODSButton {
        ODSButton(text: "Button 1", emphasis: .low) {
            // do something
        }
    }
    
    var leadingButton: ODSButton {
        ODSButton(text: "Button 2", emphasis: .low) {
            // do something
        }
    }
}

struct BannerVariantBottomSheet: View {
    
    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject var model: BannerVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Group {
                Toggle("Long Text", isOn: $model.showLongText)
                Toggle("Image", isOn: $model.showImage)
            }
            .padding(.horizontal, ODSSpacing.m)
            .odsFont(.bodyBold)
            
            ODSChipPicker(title: "Button options",
                          selection: $model.buttonsOption,
                          chips: BannerVariantModel.ButtonsOption.chips)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}
