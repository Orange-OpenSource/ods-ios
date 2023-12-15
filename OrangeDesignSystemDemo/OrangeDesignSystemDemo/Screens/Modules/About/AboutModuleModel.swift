//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import OrangeDesignSystem
import SwiftUI

// ==========================
// MARK: - About Module Model
// ==========================

class AboutModuleModel: ObservableObject {

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

        var description: LocalizedStringKey {
            switch self {
            case .appNews:
                return "screens.about.app_information.option_description.app_news"
            case .legalInformation:
                return "screens.about.app_information.option_description.legal_information"
            case .rateTheApp:
                return "screens.about.app_information.option_description.rate"
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
