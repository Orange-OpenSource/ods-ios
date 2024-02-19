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

import Foundation
import OrangeDesignSystem
import SwiftUI

// ==========================
// MARK: - About Module Model
// ==========================

final class AboutModuleModel: ObservableObject {

    // ==================
    // MARK: - Properties
    // ==================

    @Published var showFeedbackPopup: Bool
    @Published var applicationSectionOptions: [ApplicationInformationOption]
    @Published var optionalAboutItems: [OptionalAboutItem]
    @Published var numberOfCustomItems: Int

    var applicationInformation: ODSAboutApplicationInformation {
        let version = ODSApplicationVersion(marketingVersion: "0.14.0", buildNumber: "123456", buildType: "ALPHA")
        let description = °°"screens.about.app_information.description.default"
        let shareConfiguration = ODSAboutShareTheApplication(
            storeUrl: URL(string: "https://www.apple.com")!,
            subject: °°"screens.about.app_information.share.subject.default",
            description: °°"screens.about.app_information.share.description.default")

        return ODSAboutApplicationInformation(name: "Orange Design System",
                                              version: applicationSectionOptions.contains(.version) ? version : nil,
                                              description: applicationSectionOptions.contains(.description) ? description : nil,
                                              shareConfiguration: applicationSectionOptions.contains(.share) ? shareConfiguration : nil,
                                              onFeedbackClicked: applicationSectionOptions.contains(.feedback) ? onFeedbackClicked : nil)
    }

    var privacyPolicy: ODSPrivacyPolicy {
        ODSPrivacyPolicy.webview(.url(Self.privacyPolicyResourceUrl))
    }

    var appNewsPath: String? {
        optionalAboutItems.contains(.appNews)
            ? Bundle.main.path(forResource: "AppNews", ofType: "json")
            : nil
    }

    var rateTheAppUrl: URL? {
        optionalAboutItems.contains(.rateTheApp)
            ? URL(string: "https://www.apple.com/app-store/")
            : nil
    }

    var legalInformationText: String? {
        optionalAboutItems.contains(.legalInformation)
            ? °°"screens.about.legal_information_text.default"
            : nil
    }

    var customItems: [ODSAboutListItemConfig] {
        defaultCustomItems.prefix(numberOfCustomItems).compactMap { $0 as ODSAboutListItemConfig }
    }

    let defaultCustomItems: [ODSAboutListItemConfig]

    private static let privacyPolicyResourceUrl = Bundle.main.url(forResource: "PrivacyNotice", withExtension: "html")!

    /// The `URL` of the service to reach to get the list of apps to display
    static var appsRecirculationRemoteFeedURL: URL? {
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

    /// The `URL` pointing some JSON file, picked from backend, embeded in the app, containing the lsit of apps to display
    static var appsRecirculationLocalDataPath: URL {
        guard let localPath = Bundle.main.url(forResource: "AppsPlus", withExtension: "json") else {
            fatalError("Failed to URL of local data file")
        }
        return localPath
    }

    // =============
    // MARK: Methods
    // =============

    init() {
        showFeedbackPopup = false
        applicationSectionOptions = ApplicationInformationOption.allCases
        optionalAboutItems = OptionalAboutItem.allCases
        numberOfCustomItems = 2
        defaultCustomItems = [
            AboutMyRecipeItemConfiguration(),
            AboutMyReviewsItemConfiguration(),
        ]
    }

    func onFeedbackClicked() {
        showFeedbackPopup = true
    }

    // ======================================
    // MARK: - Application Information Option
    // ======================================

    enum ApplicationInformationOption: Int, CaseIterable {
        case version = 0
        case description
        case share
        case feedback

        var description: LocalizedStringKey {
            switch self {
            case .version:
                return "screens.about.app_information.option_description.version"
            case .description:
                return "screens.about.app_information.option_description.description"
            case .share:
                return "screens.about.app_information.option_description.share"
            case .feedback:
                return "screens.about.app_information.option_description.feedback"
            }
        }

        var chip: ODSFilterChip<Self> {
            .init(text: Text(description), value: self)
        }

        static var chips: [ODSFilterChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }

    // ===========================
    // MARK: - Optional About Item
    // ===========================

    enum OptionalAboutItem: Int, CaseIterable {
        case appNews = 0
        case legalInformation
        case rateTheApp
        case moreApps

        var description: LocalizedStringKey {
            switch self {
            case .appNews:
                return "screens.about.app_information.option_description.app_news"
            case .legalInformation:
                return "screens.about.app_information.option_description.legal_information"
            case .rateTheApp:
                return "screens.about.app_information.option_description.rate"
            case .moreApps:
                return "screens.about.app_information.option_description.more_apps"
            }
        }

        var chip: ODSFilterChip<Self> {
            .init(text: Text(description), value: self)
        }

        static var chips: [ODSFilterChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }
}
