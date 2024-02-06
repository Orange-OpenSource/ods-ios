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

/// The view displaying the available apps in a list
struct MoreAppsView: View {

    private let enableHaptics: Bool
    @StateObject private var viewModel: MoreAppsViewModel
    @AccessibilityFocusState private var requestFocus: Focusable?
    @Environment(\.openURL) private var openURL

    init(feedURL: URL, flattenApps: Bool, cacheAppsIcons: Bool, enableHaptics: Bool) {
        self.enableHaptics = enableHaptics
        _viewModel = StateObject(wrappedValue: MoreAppsViewModel(dataSource: .remote(url: feedURL), flattenApps: flattenApps, cacheAppsIcons: cacheAppsIcons))
    }

    init(localPath: URL, flattenApps: Bool, cacheAppsIcons: Bool, enableHaptics: Bool) {
        self.enableHaptics = enableHaptics
        _viewModel = StateObject(wrappedValue: MoreAppsViewModel(dataSource: .local(path: localPath), flattenApps: flattenApps, cacheAppsIcons: cacheAppsIcons))
    }

    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                loadingView()
            case let .loaded(appsList):
                loadedView(appsList).task {
                    if enableHaptics {
                        VibrationsManager.success()
                    }
                }
            case let .error(error):
                errorView(error).task {
                    if enableHaptics {
                        VibrationsManager.error()
                    }
                }
            }
        }
        .task {
            viewModel.fetchAvailableAppsList()
        }
    }

    // TODO: #64 - Implement loading view when the "empty state" module will be ready to be implemented
    private func loadingView() -> some View {
        Text("⏳ Loading")
    }

    // TODO: #64 - Implement error view when the "empty state" module will be ready to be implemented
    private func errorView(_ error: MoreAppsViewModel.Error) -> some View {
        Text("❌ An error occured: '\(error.localizedDescription)'")
    }

    @ViewBuilder
    private func loadedView(_ appsList: MoreAppsList) -> some View {
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
                    Text("modules.about.apps_recirculation.uncategorized_apps".🌐)
                        .accessibilityFocused($requestFocus, equals: .uncategorizedAppsSection)
                }

                ForEach(appsList.sections, id: \.self) { section in
                    listItem(for: section)
                }
            }
        }
        .accessibilityFocused($requestFocus, equals: .moreApps)
        .listStyle(.insetGrouped)
        .onAppear {
            // Voice Over gives focus to some random item in the middle of the screen in the list, need to move focus
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                if appsList.sections.isEmpty {
                    requestFocus = .moreApps
                } else {
                    requestFocus = .uncategorizedAppsSection
                }
            }
        }
    }

    @ViewBuilder
    private func listItem(for section: MoreAppsSection) -> some View {
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
                               leading: app.iconURL != nil ? .squareImage(source: viewModel.appImage(at: app.iconURL!)) : nil)
            .lineLimit(3) // 3 lines asked
            .accessibilityChildren {
                Text(app.title)
                if let description = app.description {
                    Text(description)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibilityHint(Text(°°"a11y.navigation.tap_twice_to_go_to_appstore"))

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

    @ViewBuilder
    private func contextMenu(_ storeURL: URL?) -> some View {
        if let storeURL {
            Button {
                openURL(storeURL)
            } label: {
                Text("modules.about.apps_recirculation.go_to_appstore".🌐)
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
        case moreApps
        case uncategorizedAppsSection
    }
}
