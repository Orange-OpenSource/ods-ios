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

struct ODSStandardListItem: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ODSListStandardItemModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ODSListItemContent(model: model)
    }
}

// MARK: - 

struct ODSSelectionListItem: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: ODSListSelectionItemModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        if model.trailingSelection == .checkmark {
            ODSListItemContent(model: model)
                .contentShape(Rectangle())
                .onTapGesture {
                    model.isSelected.toggle()
                }
        } else {
            ODSListItemContent(model: model)
        }
    }
}

// MARK: -

struct ODSListItemContent: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ODSListItemModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            if let leadingIcon = model.leadingIcon {
                LeadingIcon(model: leadingIcon)
                    .padding(.vertical, ODSSpacing.s)
            }

            VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                Text(LocalizedStringKey(model.title))
                    .odsFont(.bodyRegular)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)

                if let subtitle = model.subtitle {
                    Text(LocalizedStringKey(subtitle))
                        .odsFont(.footnote)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.vertical, ODSSpacing.s)

            Spacer()

            TrailingIcons(model: model)
        }
        .frame(minHeight: 44)
    }
}
