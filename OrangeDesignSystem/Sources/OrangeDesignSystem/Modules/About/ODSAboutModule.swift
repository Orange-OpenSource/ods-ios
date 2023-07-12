//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import Foundation
import SwiftUI

public struct ODSAboutModule<LegalInformation, TermsOfService>: View where LegalInformation: View, TermsOfService: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let headerIllustration: Image
    private let applicationInformation: ODSAboutApplicationInformation
    private let privacyPolicy: ODSPrivacyPolicy
    private let applicationNewsPath: String?
    private let moreAppsUrl: URL?
    private let storeUrl: URL?
    @ViewBuilder
    private let termsOfService: () -> TermsOfService
    private let legalInformation: LegalInformation
    private let customItems: [ODSAboutListItem]

    // ==================
    // MARK: Initializers
    // ==================

    /// Initializes the about module.
    ///
    /// - Parameters:
    ///     - headerIllustration: Image of the illustration at the top of the screen.
    ///     - applicationInformation: (Mandatory) Information about the application set in the area describing it.
    ///     - privacyPolicy: (Mandatory) The privacy policy of the application.
    ///     - acessibilityStatement: (Mandatory) The configuration to access the repport of the accessibility statement.
    ///     - applicationNewsPath: (Optional) Path to the json file containing the news history of all releases of the application.
    ///     - moreAppsUrl: The URL to retrieve a collection of apps and display their associated description and URL.
    ///     - storeUrl: Provide the store URL to propose the user to rate the app.
    ///     - termsOfService: (Mandatory) A view builder to provide the terms of service (could be a webview, native screen, ...)
    ///     - legalInformation: View builder to provide legal information (could be a webview, native screen, ...)
    ///     - customItems: The custom items to be added at the end of the list.
    ///
    public init(headerIllustration: Image = Image("ic_about_image", bundle: Bundle.ods),
                applicationInformation: ODSAboutApplicationInformation,
                privacyPolicy: ODSPrivacyPolicy,
                acessibilityStatement: ODSAboutAccessibilityStatement,
                applicationNewsPath: String? = nil,
                moreAppsUrl: URL? = nil,
                storeUrl: URL? = nil,
                @ViewBuilder termsOfService: @escaping () -> TermsOfService,
                @ViewBuilder legalInformation: () -> LegalInformation,
                customItems: [ODSAboutListItem] = []) {
        self.headerIllustration = headerIllustration
        self.applicationInformation = applicationInformation
        self.privacyPolicy = privacyPolicy
        self.applicationNewsPath = applicationNewsPath
        self.moreAppsUrl = moreAppsUrl
        self.storeUrl = storeUrl
        self.legalInformation = legalInformation()
        self.termsOfService = termsOfService
        self.customItems = customItems
    }

    /// Initializes the about module without LegalInformation entry.
    ///
    /// - Parameters:
    ///     - headerIllustration: Image of the illustration at the top of the screen
    ///     - applicationInformation: (Mandatory) Information about the application set in the area describing it.
    ///     - privacyPolicy: (Mandatory) The privacy policy of the application
    ///     - acessibilityStatement: (Mandatory) The configuration to access the repport of the accessibility statement.
    ///     - applicationNewsPath: (Optional) Path to the json file containing the news history of all releases of the application.
    ///     - moreAppsUrl: The URL to retrieve a collection of apps and display their associated description and URL.
    ///     - storeUrl: Provide the store URL to propose the user to rate the app.
    ///     - termsOfService: (Mandatory) A view builder to provide the terms of service (could be a webview, native screen, ...)
    ///     - customItems: The custom items to be added at the end of the list.
    ///

    public init(headerIllustration: Image = Image("ic_about_image", bundle: Bundle.ods),
                applicationInformation: ODSAboutApplicationInformation,
                privacyPolicy: ODSPrivacyPolicy,
                acessibilityStatement: ODSAboutAccessibilityStatement,
                applicationNewsPath: String? = nil,
                moreAppsUrl: URL? = nil,
                storeUrl: URL? = nil,
                @ViewBuilder termsOfService: @escaping () -> TermsOfService,
                customItems: [ODSAboutListItem] = []) where LegalInformation == EmptyView {
        self.headerIllustration = headerIllustration
        self.applicationInformation = applicationInformation
        self.privacyPolicy = privacyPolicy
        self.applicationNewsPath = applicationNewsPath
        self.moreAppsUrl = moreAppsUrl
        self.storeUrl = storeUrl
        self.legalInformation = EmptyView()
        self.termsOfService = termsOfService
        self.customItems = customItems
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        List {
            headerIllustration
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)

            Group {
                // Application Innformation section
                AboutApplicationInformation(applicationInformation: applicationInformation)
                    .padding(.vertical, ODSSpacing.m)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                // Mandatory Items
                AboutPrivacyPolicyMenuItem(policy: privacyPolicy)
                TermsOfServiceMenuItem(termsOfService: termsOfService)
                AccessibilityStatementMenuItem()

                // Optional Items
                MoreAppsMenuItem(url: moreAppsUrl)
                RateTheAppMenuItem(url: storeUrl)
                AppNewsMenuItem(path: applicationNewsPath)
                LegalInformationMenuItem(legalInformation: legalInformation)

                // Custom Additonnal Items
                CustomListItems(items: customItems)
            }
            .padding(.horizontal, ODSSpacing.m)
        }
        .listStyle(.plain)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.large)
        .background(ODSInternalColor.primaryBackground.color)
    }
}
