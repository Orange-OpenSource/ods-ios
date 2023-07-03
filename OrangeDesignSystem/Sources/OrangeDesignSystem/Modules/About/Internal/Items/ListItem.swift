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

struct AboutListItem: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: ODSListStandardItemModel
    let destination: AnyView

    // ==================
    // MARK: Initializers
    // ==================

    init(item: ODSAboutCustomListItem) {
        self.init(title: item.title, subtitle: item.subtitle, icon: item.icon, destination: item.destination)
    }

    init(title: String, subtitle: String? = nil, icon: Image? = nil, destination: AnyView) {
        self.model = ODSListStandardItemModel(title: title, subtitle: subtitle, leadingIcon: ODSListItemLeadingIcon(icon: icon))
        self.destination = destination
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationLink(model) { destination }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
    }
}

extension ODSListItemLeadingIcon {
    init?(icon: Image?) {
        guard let icon = icon else {
            return nil
        }
        self = .icon(icon)
    }
}
