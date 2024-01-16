//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

/// The view displaying the available apps in a list
struct MoreAppsView: View {

    @StateObject private var viewModel: MoreAppsViewModel
    @Environment(\.openURL) private var openURL

    init(feedURL: URL) {
        _viewModel = StateObject(wrappedValue: MoreAppsViewModel(feedURL: feedURL))
    }

    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                loadingView()
            case let .loaded(appsList):
                loadedView(appsList)
            case let .error(error):
                errorView(error)
            }
        }
        .task {
            viewModel.fetchAvailableAppsList()
        }
    }

    private func loadingView() -> some View {
        Text("Loading...") // TODO: #64 - Implement error view
    }

    private func errorView(_ error: MoreAppsViewModel.Error) -> some View {
        Text("error") // TODO: #64 - Implement error view
    }

    @ViewBuilder
    private func loadedView(_ appsList: MoreAppsList) -> some View {
        List {
            Section {
                ForEach(appsList.apps, id: \.self) { app in
                    listItem(for: app).odsListItemStyle()
                }
            } header: {
                Text("modules.about.apps_recirculation.uncategorized_apps".🌐)
            }

            ForEach(appsList.sections, id: \.self) { section in
                listItem(for: section)
            }
        }
        .listStyle(.insetGrouped)
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
                               leading: app.iconURL != nil ? .squareImage(source: .asyncImage(app.iconURL!, Image("ods_empty"))) : nil) // #TODO #64 - Check image if empty case
            .lineLimit(3) // 3 lines asked

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
                .odsFont(.title1)
            Text(description)
                .odsFont(.bodyRegular)
                .frame(idealWidth: UIScreen.main.nativeBounds.size.width * 2, // Trick to be enough wide to get all available space
                       idealHeight: UIScreen.main.nativeBounds.size.height) // Trick to make the preview enough big to display more text
        }.padding(ODSSpacing.s)
    }
}
