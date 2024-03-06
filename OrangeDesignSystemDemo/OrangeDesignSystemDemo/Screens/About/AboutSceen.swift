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

import OrangeDesignSystem
import SwiftUI

// MARK: - About Changelog Item Config

struct AboutChangelogItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored properties
    // =======================

    let title: String
    let icon: Image
    let priority: ODSAboutListItemPriority
    let target: ODSAboutListItemTarget

    // =================
    // MARK: Initializer
    // =================

    init(priority: ODSAboutListItemPriority) {
        title = °°"screens.about.changelog.title"
        icon = Image("ic_taskList", bundle: Bundle.ods)
        self.priority = priority
        target = .destination(AnyView(
            AboutHtmlAndMarkdownView(title: °°"screens.about.changelog.title", markdownFileName: "CHANGELOG", convertToHtml: true)))
    }
}

// MARK: - About Design Guidelines Item Config

struct AboutDesignGuidelinesItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored properties
    // =======================

    let title: String
    let icon: Image
    let target: ODSAboutListItemTarget
    let priority: ODSAboutListItemPriority

    // =================
    // MARK: Initializer
    // =================

    init(priority: ODSAboutListItemPriority) {
        title = °°"screens.about.design_guidelines.title"
        icon = Image("ic_tools", bundle: Bundle.main)
        self.priority = priority
        target = .action { UIApplication.shared.open(URL(string: "https://system.design.orange.com/0c1af118d/p/95b685-ios/")!) }
    }
}

// MARK: - About Screen

struct AboutScreen: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private var applicationInformation: ODSAboutApplicationInformation
    private let privacyPolicy: ODSPrivacyPolicy
    private let accessibilityStatement: ODSAboutAccessibilityStatement
    private var customItems: [ODSAboutListItemConfig]

    // =================
    // MARK: Initializer
    // =================

    init() {
        applicationInformation = ODSAboutApplicationInformation(
            name: °°"screens.about.app_information.name",
            version: ODSApplicationVersion(marketingVersion: Bundle.main.marketingVersion, buildNumber: Bundle.main.buildNumber ?? "", buildType: Bundle.main.fullBuildType),
            description: °°"screens.about.app_information.description",
            shareConfiguration: ODSAboutShareTheApplication(
                storeUrl: URL(string: "http://oran.ge/dsapp")!,
                subject: °°"screens.about.app_information.share.subject",
                description: °°"screens.about.app_information.share.description"),
            onFeedbackClicked: {
                UIApplication.shared.open(URL(string: "https://github.com/Orange-OpenSource/ods-ios/issues/new/choose")!)
            })

        privacyPolicy = ODSPrivacyPolicy.webview(.url(Bundle.main.url(forResource: "PrivacyNotice", withExtension: "html")!))

        accessibilityStatement = ODSAboutAccessibilityStatement(
            conformityStatus: "Accessibility: partially conform",
            fileName: "AccessibilityStatement",
            reportDetail: URL(string: "https://la-va11ydette.orange.com/")!)

        customItems = [
            AboutDesignGuidelinesItemConfig(priority: 202),
            ODSAboutAppNewsItemConfig(priority: 201, path: Bundle.main.path(forResource: "AppNews", ofType: "json")!),
            AboutChangelogItemConfig(priority: 200),
        ]

        if let feedURL = Self.recirculationRemoteFeedURL {
            customItems.append(ODSRecirculationItemConfig(dataSource: .remote(url: feedURL), priority: 199))
        } else {
            Log.warning("Missing configuration for this recirculation module, did you use a working URL?")
        }
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ODSAboutModule(headerIllustration: ThemeProvider().imageFromResources(name: "AboutImage"),
                           applicationInformation: applicationInformation,
                           privacyPolicy: privacyPolicy,
                           acessibilityStatement: accessibilityStatement,
                           termsOfService: termsOfService,
                           listItemConfigurations: customItems)
        }
        .navigationbarMenuForThemeSelection()
        .navigationViewStyle(.stack)
    }

    // ====================
    // MARK: Private helper
    // ====================

    @ViewBuilder
    private func termsOfService() -> some View {
        AboutHtmlAndMarkdownView(title: °°"screens.about.terms_of_service", htmlFileName: "CGU")
    }

    private static var recirculationRemoteFeedURL: URL? {
        guard let appsPlusURL = Bundle.main.infoDictionary?["APPS_PLUS_URL"] as? String, !appsPlusURL.isEmpty else {
            Log.warning("No Apps Plus URL found in app settings")
            return nil
        }
        let currentLocale = Bundle.main.preferredLocalizations[0]
        let requestURL = "\(appsPlusURL)&lang=\(currentLocale)"
        guard let feedURL = URL(string: requestURL) else {
            Log.warning("Failed to forge the service URL to get more apps")
            return nil
        }
        return feedURL
    }
}

#if DEBUG
// MARK: - About Screen Preview Provider

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            AboutScreen().preferredColorScheme($0)
        }
    }
}
#endif
