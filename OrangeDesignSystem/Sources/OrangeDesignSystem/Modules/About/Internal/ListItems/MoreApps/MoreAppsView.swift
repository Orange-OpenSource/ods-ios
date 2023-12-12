//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

struct MoreAppsView: View {

    @StateObject private var viewModel: MoreAppsViewModel

    init(feedURL: URL) {
        _viewModel = StateObject(wrappedValue: MoreAppsViewModel(feedURL: feedURL))
    }

    var body: some View {
        ScrollView {
            switch viewModel.loadingState {
            case .loading:
                loadingView()
            case let .loaded(appsList):
                loadedView(appsList)
            case let .error(error):
                errorView(error)
            }
        }.task {
            viewModel.fetchAvailableAppsList()
        }
    }

    private func loadingView() -> some View {
        Text("Loading...")
    }

    private func errorView(_ error: MoreAppsViewModel.Error) -> some View {
        Text("error")
    }

    @ViewBuilder
    private func loadedView(_ appsList: MoreAppsList) -> some View {

        Text("Bon appetit!")

//        List {
//            ForEach(appsList.apps, id: \.title) { app in
//                NavigationLink {
//                    Text("Bon appetit!")
//                } label: {
//                    ODSListItem(title: Text(app.title),
//                                subtitle: app.description != nil ? Text(app.description!) : nil,
//                                leading: app.iconURL != nil ? .circularImage(source: .asyncImage(app.iconURL!, Image("ods_empty"))) : nil)
//                }
//                // .odsListItemStyle()
//            }
//
//            ForEach(appsList.sections, id: \.description) { section in
//                NavigationLink {
//                    Text("Bon appetit!")
//                } label: {
//                    ODSListItem(title: Text(section.description),
//                                subtitle: nil)
//                }
//                // .odsListItemStyle()
//            }
//
//        }.listStyle(.plain)
    }
}
