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

    let releaseDescriptions: [AboutReleaseDescription]

    // =================
    // MARK: Initializer
    // =================

    init(fromFile path: String) {
        releaseDescriptions = (try? AboutReleaseDescriptionsLoader().load(from: path)) ?? []
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            if releaseDescriptions.isEmpty {
                Text(°°"modules.about.app_news.no_news")
            } else {
                ForEach(releaseDescriptions, id: \.version) { releaseDescription in
                    AboutReleaaseDescriptionEntry(releaseDescription: releaseDescription)
                        .padding(.horizontal, ODSSpacing.m)
                    Divider()
                }
            }
        }
    }
}

// =======================================
// MARK: - About Release Description Entry
// =======================================

private struct AboutReleaaseDescriptionEntry: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let releaseDescription: AboutReleaseDescription

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.s) {
            HStack {
                Text(releaseDescription.version).odsFont(.headline)
                Spacer()
                Text(formatedDate).odsFont(.caption1Regular)
            }

            Text(releaseDescription.news)
                .odsFont(.callout)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, ODSSpacing.s)
    }

    // ====================
    // MARK: Private Helper
    // ====================

    private var formatedDate: String {
        DateFormatter.localizedFormat(date: releaseDescription.date,
                                      for: Bundle.main,
                                      dateStyle: .short,
                                      timeStyle: .none)
    }
}
