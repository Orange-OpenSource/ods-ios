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

enum ContentType: String, CaseIterable {
    case tutorial
    case example

    var chip: ODSChip<Self> {
        ODSChip(self, text: self.rawValue.capitalized)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases.map { $0.chip }
    }
}

class BottomSheetVariantModel: ObservableObject {
    
    // ======================
    // MARK: Store properties
    // ======================

    @Published var bottomSheetSize: ODSBottomSheetSize
    @Published var contentType: ContentType
    @Published var showSubtitle: Bool {
        didSet { if showSubtitle { showIcon = false } }
    }
    @Published var showIcon: Bool {
        didSet { if showIcon { showSubtitle = false } }
    }
    
    @Published var selectedRecipe: Recipe?
        
    // =================
    // MARK: Initializer
    // =================

    init() {
        self.bottomSheetSize = .small
        self.showSubtitle = false
        self.showIcon = false
        self.contentType = .example
    }
}

struct BottomSheetVariantOptions: View {
    
    // ======================
    // MARK: Store properties
    // ======================
    
    @ObservedObject var model: BottomSheetVariantModel
    
    // ==========
    // MARK: Body
    // ==========
    
    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Group {
                ODSChipPicker(title: "Detent",
                              selection: $model.bottomSheetSize,
                              chips: ODSBottomSheetSize.chips)

                ODSChipPicker(title: "Content",
                              selection: $model.contentType,
                              chips: ContentType.chips)

                Toggle("Subtitle", isOn: $model.showSubtitle)
                    .padding(.horizontal, ODSSpacing.m)
                    .disabled(model.showIcon)

                Toggle("Icon", isOn: $model.showIcon)
                    .padding(.horizontal, ODSSpacing.m)
                    .disabled(model.showSubtitle)
            }
        }
        .odsFont(.bodyRegular)
    }
}


extension ODSBottomSheetSize {
    var description: String {
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .hidden:
            return "Hidden"
        }
    }
    
    var chip: ODSChip<Self> {
        ODSChip(self, text: self.description)
    }
    
    static var chips: [ODSChip<Self>] {
        Self.allCases
            .filter { $0 != .hidden }
            .map { $0.chip }
    }
}
