////
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

/// Describes the trailing icon of the list item for additional actions.
/// A text or an "i" button are available.

public struct OBSListItem: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: Text
    private let subtitle: Text?
    private let leadingIcon: ODSListItemLeadingIcon?
    private let tv: (() -> ODSListItemTrailing)?

    /// Describe the Item content.
    ///
    /// - Parameters:
    ///     - title: The primary text of the list item
    ///     - subtile: The secondary text of the list item (optional)
    ///     - leadingIcon: The leading icon of the list item (optional)
    ///     - trailingActions: The trailing actions (optional)
    ///
    public init(
        title: Text,
        subtitle: Text? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        tv: (() -> ODSListItemTrailing)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.tv = tv
    }

    public init(
        title: Text,
        subtitle: Text? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.tv = nil
    }

    public init(
        title: Text,
        subtitle: Text? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        tralingText: Text
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.tv = { ODSListItemTrailing(text: tralingText) }
    }
    
    public init(
        title: Text,
        subtitle: Text? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        trailingText: Text? = nil,
        trailingIButtonAction: @escaping () -> Void
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        if let trailingText = trailingText {
            self.tv = { ODSListItemTrailing(text: trailingText, action: trailingIButtonAction) }
        } else {
            self.tv = { ODSListItemTrailing(action: trailingIButtonAction) }
        }
    }

    public init(
        title: Text,
        subtitle: Text? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        tralingToggle: Binding<Bool>
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.tv = { ODSListItemTrailing(toogleIsOn: tralingToggle) }
    }
    
    public init(
        title: Text,
        subtitle: Text? = nil,
        leadingIcon: ODSListItemLeadingIcon? = nil,
        checkmarkIsSelected: Bool
    ) {
        self.title = title
        self.subtitle = subtitle
        self.leadingIcon = leadingIcon
        self.tv = { ODSListItemTrailing(checkmarkIsVisible: checkmarkIsSelected) }
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            OBSListItemContent(title: title, subtitle: subtitle, leadingIcon: leadingIcon)
            tv?()
        }
        .frame(minHeight: 44)
        .contentShape(Rectangle())
        .listRowInsets(EdgeInsets())
        .listRowSeparator(Visibility.visible)
    }
}

struct OBSListItemContent: View {

    let title: Text
    let subtitle: Text?
    let leadingIcon: ODSListItemLeadingIcon?

    var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            if let leadingIcon = self.leadingIcon {
                LeadingIcon(model: leadingIcon)
                    .padding(.vertical, ODSSpacing.s)
            }

            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                title
                    .odsFont(.bodyRegular)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)

                subtitle?
                    .odsFont(.footnote)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, ODSSpacing.s)
        }
    }
}
//
//private struct OBSTrailingActions: View {
//
//    // ======================
//    // MARK: Store Properties
//    // ======================
//
//    let actions: OBSListItem.TrailingActions
//
//    // ==========
//    // MARK: Body
//    // ==========
//
//    var body: some View {
//        HStack(spacing: ODSSpacing.s) {
//            actions.text?
//                .odsFont(.subhead)
//                .foregroundColor(Color(UIColor.systemGray3))
//
//            if let iButtonAction = actions.iButtonAction {
//                ODSIconButton(image: Image(systemName: "info.circle"), action: iButtonAction)
//                    .buttonStyle(PlainButtonStyle())
//            }
//        }
//    }
//}
