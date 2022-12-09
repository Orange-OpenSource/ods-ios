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

struct TrailingIcons: View {

    // ======================
    // MARK: Store Properties
    // ======================

    let model: ODSListItemModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        if let actionModel = (model as? ODSListStandardItemModel)?.trailingActions {
            TrailingActions(model: actionModel)
        }

        if let selectionModel = model as? ODSListSelectionItemModel {
            TrailingSelections(model: selectionModel)
        }
    }
}

struct TrailingActions: View {

    // ======================
    // MARK: Store Properties
    // ======================

    let model: ODSListItemTrailingActions

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        HStack {
            if let text = model.displayText {
                Text(text)
                    .odsFont(.subhead)
                    .foregroundColor(Color(UIColor.systemGray3))
            }

            if let onIButtionClicked = model.onIButtionClicked {
                ODSIconButton(image: Image(systemName: "info.circle"), action: onIButtionClicked)
            }
        }
    }
}

struct TrailingSelections: View {

    // ======================
    // MARK: Store Properties
    // ======================

    @ObservedObject var model: ODSListSelectionItemModel
    @Environment(\.theme) var theme

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch model.trailingSelection {
        case .toggle:
            Toggle(isOn: $model.isSelected) {
                EmptyView()
            }
        case .checkmark:
            if model.isSelected {
                Image("controlsTableViewRowXCheckmark", bundle: Bundle.ods)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(theme.componentColors.accent)
                    .frame(height: 44)
            }
        }
    }
}
