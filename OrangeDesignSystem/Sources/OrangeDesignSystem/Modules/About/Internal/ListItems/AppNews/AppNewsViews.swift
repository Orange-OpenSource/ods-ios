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

// =====================
// MARK: - App News List
// =====================

struct AppNewsList: View {

    @AccessibilityFocusState private var requestFocus: AccessibilityFocusable?
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
                AboutErrorView(text: Text("modules.about.app_news.no_news".🌐))
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
                .accessibilityFocused($requestFocus, equals: .some(id: item.version))
                .odsRequestAccessibleFocus(_requestFocus, for: .some(id: data[0].version))
            Divider()
        }
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

    private var localizedAccessibleDate: String {
        return DateFormatter.localizedString(from: releaseDescription.date, dateStyle: .long, timeStyle: .none)
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
                    .accessibilityLabel(localizedAccessibleDate)
            }

            Text(releaseDescription.news)
                .odsFont(.bodyM)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, ODSSpacing.s)
        .accessibilityElement(children: .combine)
    }
}
