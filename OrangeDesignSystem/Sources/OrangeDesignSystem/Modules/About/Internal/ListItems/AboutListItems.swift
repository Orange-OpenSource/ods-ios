//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
        self.configurations = configurations
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
        case let .action(action):
            Button {
                action()
            } label: {
                ODSListItem(title: Text(configuration.title), leading: ODSListItem.Leading(icon: configuration.icon))
            }
            .odsListItemStyle(showSeparator: false)

        case let .destination(destination):
            NavigationLink {
                destination.navigationTitle(configuration.title)
            } label: {
                ODSListItem(title: Text(configuration.title), leading: ODSListItem.Leading(icon: configuration.icon))
            }
            .odsListItemStyle(showSeparator: false)
        }
    }
}

extension ODSListItem.Leading {
    init?(icon: Image?) {
        guard let icon = icon else {
            return nil
        }
        self = .icon(icon)
    }
}
