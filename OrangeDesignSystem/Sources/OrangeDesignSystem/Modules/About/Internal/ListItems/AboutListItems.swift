//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
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
