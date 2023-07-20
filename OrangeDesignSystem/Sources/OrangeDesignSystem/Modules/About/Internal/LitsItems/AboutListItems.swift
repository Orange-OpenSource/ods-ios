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

struct AboutListItems: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let configurations: [ODSAboutListItemConfig]

    // =================
    // MARK: Initializer
    // =================

    init(configurations: [ODSAboutListItemConfig]) {
        self.configurations = configurations.sorted(by: { $0.priority > $1.priority })
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ForEach(configurations, id: \.title) { configuration in
            item(from: configuration)
        }
    }

    // ============
    // MARK: Helper
    // ============

    @ViewBuilder
    private func item(from configuration: ODSAboutListItemConfig) -> some View {
        switch configuration.target {
        case .action(let action):
            Button {
                action()
            } label: {
                ODSListStandardItem(model: configuration.model)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)

        case .destination(let destination):
            NavigationLink(configuration.model) { destination.navigationTitle(configuration.title) }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
        }
    }
}

extension ODSAboutListItemConfig {
    var model: ODSListStandardItemModel {
        ODSListStandardItemModel(title: self.title, leadingIcon: ODSListItemLeadingIcon(icon: self.icon))
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
