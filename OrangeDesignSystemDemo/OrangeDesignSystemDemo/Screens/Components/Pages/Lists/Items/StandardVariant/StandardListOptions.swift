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

struct StandardListVariantOptions: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: StandardListVariantModel

    enum OptionSelection: Int {
        case item = 0
        case list = 1
    }
    @State private var options: OptionSelection = .item

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            Picker("", selection: $options) {
                Text("Item").tag(OptionSelection.item)
                Text("List").tag(OptionSelection.list)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, ODSSpacing.m)
            
            switch options {
            case .item:
                itemOptions
            case .list:
                listOption
            }
        }
        .padding(.top, ODSSpacing.s)
    }
    
    // ====================
    // MARK: Private Helpes
    // ====================

    private var itemOptions: some View {
        VStack(spacing: ODSSpacing.none) {
            Toggle(isOn: $model.showSubtitle) {
                Text("Subtitle").odsFont(.bodyBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
            
            ODSChipPicker(title: "Leading",
                          selection: $model.leadingIconOption,
                          chips: LeadingIconOption.chips)
            .padding(.vertical, ODSSpacing.s)
            
            ODSChipPicker(title: "Trailing",
                          selection: $model.trailingOptions,
                          allowZeroSelection: true,
                          chips: TrailingOption.chips)
            .padding(.vertical, ODSSpacing.s)
            
            Toggle(isOn: $model.showDetails) {
                Text("Navigate").odsFont(.bodyBold)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.vertical, ODSSpacing.s)
        }
    }
    
    private var listOption: some View {
        VStack {
            ODSChipPicker(title: "Section",
                          selection: $model.sectionOptions,
                          allowZeroSelection: true,
                          chips: SectionListOption.chips)
            
            ODSChipPicker(title: "Style",
                          selection: $model.listStyle,
                          chips: StandardListVariantModel.ODSListStyle.chips)

        }
        .padding(.vertical, ODSSpacing.s)
    }
}
