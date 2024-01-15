//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

// =====================
// MARK: - App News List
// =====================

struct AppNewsList: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject private var viewModel: AppNewsListViewModel

    // =================
    // MARK: Initializer
    // =================

    init(viewModel: AppNewsListViewModel) {
        self.viewModel = viewModel
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            switch viewModel.releaseDescriptions {
            case .loading:
                loadingView()
            case let .loaded(releaseDescription) where !releaseDescription.isEmpty:
                loadedView(releaseDescription)
            default: // case .error, case .loaded(let releaseDescription) where releaseDescription.isEmpty:
                errorView()
            }
        }.task {
            viewModel.load()
        }
    }

    // ===========
    // MARK: Views
    // ===========

    private func loadingView() -> some View {
        Text(°°"shared.loading")
    }

    private func loadedView(_ data: [AboutReleaseDescription]) -> some View {
        ForEach(data, id: \.version) { item in
            AboutReleaseDescriptionEntry(releaseDescription: item)
                .padding(.horizontal, ODSSpacing.m)
            Divider()
        }
    }

    private func errorView() -> some View {
        Text(°°"modules.about.app_news.no_news")
    }
}

// =======================================
// MARK: - About Release Description Entry
// =======================================

private struct AboutReleaseDescriptionEntry: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let releaseDescription: AboutReleaseDescription

    private var formatedDate: String {
        DateFormatter.localizedFormat(date: releaseDescription.date,
                                      for: Bundle.main,
                                      dateStyle: .short,
                                      timeStyle: .none)
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.s) {
            HStack {
                Text(releaseDescription.version).odsFont(.headlineS)
                Spacer()
                Text(formatedDate).odsFont(.labelMRegular)
            }

            Text(releaseDescription.news)
                .odsFont(.bodyM)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, ODSSpacing.s)
    }
}
