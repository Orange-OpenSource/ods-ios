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

// ==============
// MARK: - Source
// ==============

/// The source of data the module must use to get all available apps
public enum ODSMoreAppsDataSource {

    /// Fetch some backend available at `url` with sufficient `URL` for data retrievement
    case remote(url: URL)
    /// Get useful data from some local file available at `path`
    case local(path: URL)
}

/// The view displaying the available apps in a list
public struct ODSMoreAppsView: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let enableHaptics: Bool
    @StateObject private var viewModel: ODSMoreAppsModel
    @AccessibilityFocusState private var requestFocus: Focusable?
    @Environment(\.openURL) private var openURL
    @Environment(\.theme) private var theme

    // ==================
    // MARK: Initializers
    // ==================

    public init(dataSource: ODSMoreAppsDataSource,
                flattenApps: Bool,
                cacheAppsIcons: Bool,
                enableHaptics: Bool) {
        self.enableHaptics = enableHaptics
        _viewModel = StateObject(wrappedValue: ODSMoreAppsModel(dataSource: dataSource, flattenApps: flattenApps, cacheAppsIcons: cacheAppsIcons))
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading, .idle:
                loadingView()
            case let .loaded(appsList):
                loadedView(appsList).task {
                    if enableHaptics {
                        VibrationsManager.success()
                    }
                }
            case .error:
                errorView().task {
                    if enableHaptics {
                        VibrationsManager.error()
                    }
                }
            }
        }
        .refreshable {
            viewModel.fetchAvailableAppsList()
        }
        .task {
            if case .idle = viewModel.loadingState {
                viewModel.fetchAvailableAppsList()
            }
        }
    }

    // =====================
    // MARK: Private Helpers
    // =====================

    private func loadingView() -> some View {
        ODSEmptyStateView(
            title: Text(°°"modules.moreApps.loading.title"),
            text: Text(°°"modules.moreApps.loading.text"),
            image: Image("il_emptyStateUserCleared", bundle: theme.bundle)
        )
    }

    private func errorView() -> some View {
        ODSEmptyStateView(
            title: Text(°°"modules.moreApps.error.title"),
            text: Text(°°"modules.moreApps.error.text"),
            image: Image("il_emptyStateError", bundle: theme.bundle)
        )
    }

    @ViewBuilder
    private func loadedView(_ appsList: MoreAppsAppsList) -> some View {
        List {
            if appsList.sections.isEmpty {
                ForEach(appsList.apps, id: \.self) { app in
                    listItem(for: app).odsListItemStyle()
                }
            } else {
                Section {
                    ForEach(appsList.apps, id: \.self) { app in
                        listItem(for: app).odsListItemStyle()
                    }
                } header: {
                    Text("modules.moreApps.uncategorized_apps".🌐)
                        .accessibilityFocused($requestFocus, equals: .uncategorizedAppsSection)
                }

                ForEach(appsList.sections, id: \.self) { section in
                    listItem(for: section)
                }
            }
        }
        .accessibilityFocused($requestFocus, equals: .appsList)
        .listStyle(.insetGrouped)
        .onAppear {
            // Voice Over gives focus to some random item in the middle of the screen in the list, need to move focus
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if appsList.sections.isEmpty {
                    requestFocus = .appsList
                } else {
                    requestFocus = .uncategorizedAppsSection
                }
            }
        }
    }

    @ViewBuilder
    private func listItem(for section: MoreAppsAppsListSection) -> some View {
        Section {
            ForEach(section.apps, id: \.self) { app in
                listItem(for: app).odsListItemStyle()
            }
        } header: {
            Text(section.description)
        }
    }

    @ViewBuilder
    private func listItem(for app: MoreAppsAppDetails) -> some View {
        let item = ODSListItem(title: Text(app.title),
                               subtitle: app.description != nil ? Text(app.description!) : nil,
                               subtitleNumberOfLines: .two,
                               leading: leadingAppIcon(from: app))
            .accessibilityChildren {
                Text(app.title)
                if let description = app.description {
                    Text(description)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityHint(Text("a11y.navigation.tap_twice_to_go_to_appstore".🌐))

        /*
         Asked to let user read more text if possible even if lines are limited.
         Since iOS 16 it's possible to have a custom preview for peek'n'pop feature.
         With custom preview we'll be able to display more text.
         To heavy to implement yet for iOS < 16.
         */
        if #available(iOS 16, *), let appDescription = app.description {
            item.contextMenu {
                contextMenu(app.storeURL)
            } preview: {
                contextMenuPreview(app.title, appDescription)
            }
            .onTapGesture {
                if let appStoreURL = app.storeURL {
                    openURL(appStoreURL)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            item.onTapGesture {
                if let appStoreURL = app.storeURL {
                    openURL(appStoreURL)
                }
            }
        }
    }

    private func leadingAppIcon(from appDetails: MoreAppsAppDetails) -> ODSListItem.Leading? {
        guard let appIconUrl = appDetails.iconURL else {
            return nil
        }
        return .appIcon(source: viewModel.appImage(at: appIconUrl))
    }

    @ViewBuilder
    private func contextMenu(_ storeURL: URL?) -> some View {
        if let storeURL {
            Button {
                openURL(storeURL)
            } label: {
                Text("modules.moreApps.go_to_appstore".🌐)
            }
        }
    }

    @ViewBuilder
    private func contextMenuPreview(_ title: String, _ description: String) -> some View {
        Group {
            Text(title)
                .odsFont(.titleL)
            Text(description)
                .odsFont(.bodyLRegular)
                .frame(idealWidth: UIScreen.main.nativeBounds.size.width * 2, // Trick to be enough wide to get all available space
                       idealHeight: UIScreen.main.nativeBounds.size.height) // Trick to make the preview enough big to display more text
        }.padding(ODSSpacing.s)
    }

    // ============
    // MARK: - A11Y
    // ============

    private enum Focusable: Hashable {
        case appsList
        case uncategorizedAppsSection
    }
}
