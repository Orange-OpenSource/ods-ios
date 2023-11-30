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

    init() {
        _viewModel = StateObject(wrappedValue: MoreAppsViewModel())
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
        Text("===== APPS =====")
        ForEach(appsList.apps, id: \.title) { app in
            Text(app.title)
        }

        Text("===== SECTIONS =====")
        ForEach(appsList.sections, id: \.description) { section in
            Text(section.description)
            ForEach(section.apps, id: \.title) { app in
                Text(app.title)
            }
        }
    }
}
