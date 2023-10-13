/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import SwiftUI

// MARK: - About Application Information View

struct AboutApplicationInformation: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let applicationInformation: ODSAboutApplicationInformation

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            Text(LocalizedStringKey(applicationInformation.name))
                .odsFont(.largeTitle)
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityAddTraits(.isHeader)

            if applicationInformation.shareConfiguration != nil || applicationInformation.onFeedbackClicked != nil {
                HStack(spacing: ODSSpacing.none) {
                    if let shareConfiguration = applicationInformation.shareConfiguration {
                        ODSButton(text: Text("modules.about.share".localized()), image: Image("ic_share", bundle: Bundle.ods), emphasis: .lowest) {
                            ShareSheet.show(content: shareConfiguration.description, subject: shareConfiguration.subject, url: shareConfiguration.storeUrl)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(Color.accentColor)
                    }

                    if let onFeedbackClicked = applicationInformation.onFeedbackClicked {
                        ODSButton(text: Text("modules.about.feedback".localized()), image: Image("ic_comments", bundle: Bundle.ods), emphasis: .lowest, action: onFeedbackClicked)
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(Color.accentColor)
                    }
                }
                .padding(.vertical, -ODSSpacing.m)
                .padding(.leading, -ODSSpacing.m)
            }

            if let version = fullVersionText {
                VStack(alignment: .leading) {
                    Text(version)
                    Text(LocalizedStringKey(applicationInformation.copyrightNotice))
                }
                .fixedSize(horizontal: false, vertical: true)
            }

            if let description = applicationInformation.description {
                Text(LocalizedStringKey(description)).fixedSize(horizontal: false, vertical: true)
            }
        }
    }

    // =============
    // MARK: Helpers
    // =============

    private var fullVersionText: String? {
        guard let version = applicationInformation.version else {
            return nil
        }

        return "modules.about.app_information.full_version_text".localized(with: "\(version.marketingVersion)\(buildSuffix)")
    }

    private var buildSuffix: String {
        guard let buildNumber = applicationInformation.version?.buildNumber,
              !buildNumber.isEmpty else {
            return ""
        }
        return " (\(buildNumber))\(buildTypeSuffix)"
    }

    private var buildTypeSuffix: String {
        guard let buildType = applicationInformation.version?.buildType,
              !buildType.isEmpty else {
            return ""
        }
        return " - \(buildType)"
    }
}

#if DEBUG
// MARK: - Preview Provider

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        let appInfo = ODSAboutApplicationInformation(
            name: "APP NAME",
            version: ODSApplicationVersion(marketingVersion: "1.0.0", buildNumber: "123456789", buildType: "ALPHA"),
            description: "This is the demo application for test")

        ForEach(ColorScheme.allCases, id: \.self) {
            AboutApplicationInformation(applicationInformation: appInfo)
                    .preferredColorScheme($0)
        }
    }
}
#endif
