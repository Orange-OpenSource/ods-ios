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

struct LeadingIcon: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ODSListItemLeadingIcon

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch model {
        case .icon(let image):
            image.renderingMode(.template)
        case .circularImage(let source):
            AsyncIcon(source: source)
                .frame(width: width, height: height)
                .clipShape(Circle())
        case .squareImage(let source):
            AsyncIcon(source: source)
                .frame(width: width, height: height)
                .clipShape(Rectangle())
        case .wideImage(let source):
            AsyncIcon(source: source)
                .frame(width: width, height: height)
                .clipShape(Rectangle())
        }
    }

    // =====================
    // MARK: Private helpers
    // =====================

    private var width: CGFloat {
        switch model {
        case  .icon, .circularImage, .squareImage:
            return 44
        case .wideImage:
            return 80
        }
    }

    private var height: CGFloat {
        return 44
    }
}

private struct AsyncIcon: View {

    // ======================
    // MARK: Store Properties
    // ======================

    let source: ODSListItemLeadingIcon.Source

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch source {
        case let .asyncImage(url, placeHolder):
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                placeHolder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }

        case let .image(image):
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
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

struct TrailingIcons: View {

    // ======================
    // MARK: Store Properties
    // ======================

    @ObservedObject var model: ODSListItemModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        if let actions = model.trailingActions {
            TrailingActions(model: actions)
        } else {
            if let selection = model.trailingSelection {
                TrailingSelectionIcons(selection: selection, isSelected: $model.isSelected)
            }
        }
    }
}

struct TrailingSelectionIcons: View {

    // ======================
    // MARK: Store Properties
    // ======================
    @Environment(\.theme) var theme

    let selection: ODSListItemTrailingSelection
    let isSelected: Binding<Bool>

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch selection {
        case .toggle:
            Toggle(isOn: isSelected) {
                EmptyView()
            }
        case .checkmark:
            if isSelected.wrappedValue {
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
