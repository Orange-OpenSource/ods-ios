//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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

// MARK: - Apps Recirculation Item Config

struct MoreAppsItemConfig: ODSAboutListItemConfig {

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

    init() {
        title = °°"screens.about.apps_recirculation.title"
        icon = Image("ic_mobile_apps", bundle: Bundle.main)
        priority = .moreApps
        target = .destination(AnyView(Text(°°"screens.about.apps_recirculation.title")))
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
    private let customItems: [ODSAboutListItemConfig]

    // =================
    // MARK: Initializer
    // =================

    init() {
        applicationInformation = ODSAboutApplicationInformation(
            name: °°"screens.about.app_information.name",
            version: ODSApplicationVersion(marketingVersion: Bundle.main.marketingVersion, buildNumber: Bundle.main.buildNumber ?? "", buildType: Bundle.main.buildType),
            description: °°"screens.about.app_information.description",
            shareConfiguration: ODSAboutShareTheApplication(
                storeUrl: URL(string: "http://oran.ge/dsapp")!,
                subject: °°"screens.about.app_information.share.subject",
                description: °°"screens.about.app_information.share.description"),
            onFeedbackClicked: {
                UIApplication.shared.open(URL(string: "https://github.com/Orange-OpenSource/ods-ios/issues/new/choose")!)
            })

        privacyPolicy = ODSPrivacyPolicy.webview(.url(Bundle.main.url(forResource: "PrivacyNotice", withExtension: "html")!))

        accessibilityStatement = ODSAboutAccessibilityStatement(fileName: "AccessibilityStatement", reportDetail: URL(string: "https://la-va11ydette.orange.com/")!)

        customItems = [
            AboutDesignGuidelinesItemConfig(priority: 202),
            ODSAboutAppNewsItemConfig(priority: 201, path: Bundle.main.path(forResource: "AppNews", ofType: "json")!),
            AboutChangelogItemConfig(priority: 200),
            MoreAppsItemConfig(),
        ]
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            ODSAboutModule(headerIllustration: ThemeProvider().imageFromResources("AboutImage"),
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
