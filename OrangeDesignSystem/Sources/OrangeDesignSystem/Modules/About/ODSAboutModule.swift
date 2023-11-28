//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

/// Use the about module to display application name, software version,
/// legal data protection, privacy and accessibilty statements,
/// and terms of service compliance information.
///
/// It is also configurable to add some additional items to display
/// pages related to the service provided by the application
/// (i.e. settings, tutorials, ...).
public struct ODSAboutModule<TermsOfService>: View where TermsOfService: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let headerIllustration: Image
    private let applicationInformation: ODSAboutApplicationInformation
    private let listItemConfigurations: [ODSAboutListItemConfig]

    // ==================
    // MARK: Initializers
    // ==================

    /// Initializes the about module.
    ///
    /// - Parameters:
    ///    - headerIllustration: Image of the illustration at the top of the screen.
    ///    - applicationInformation: (Mandatory) Information about the application.
    ///    - privacyPolicy: (Mandatory) The privacy policy of the application.
    ///    - acessibilityStatement: (Mandatory) The configuration to access the report of the accessibility statement.
    ///    - termsOfService: (Mandatory) A view builder to provide the terms of service (could be a webview, native screen, ...)
    ///    - listItemConfigurations: Configuration to add items in the list. The items are ordered according to the priority set in configutation.
    ///
    ///  @Remark: Privacy Policy, accessibility statement and terms of service pages are
    ///  mandatory in this module. To access those pages, associated items are automatically
    ///  added in the list. They are ordered according to their priority defined by:
    ///  __ODSAboutListItemPriority.privacyPolicy__, __ODSAboutListItemPriority.termOfService__, __ODSAboutListItemPriority.accessibilityStatement__.
    ///  If custom items should be placed before those, configures them with lower priority.
    ///
    public init(
        headerIllustration: Image = Image("il_about", bundle: Bundle.ods),
        applicationInformation: ODSAboutApplicationInformation,
        privacyPolicy: ODSPrivacyPolicy,
        acessibilityStatement: ODSAboutAccessibilityStatement,
        @ViewBuilder termsOfService: @escaping () -> TermsOfService,
        listItemConfigurations: [ODSAboutListItemConfig])
    {
        self.headerIllustration = headerIllustration
        self.applicationInformation = applicationInformation

        let internalItemsConfig: [ODSAboutListItemConfig] = [
            AboutPrivacyPolicyItem(policy: privacyPolicy),
            AboutTermOfServiceItem(termsOfService: termsOfService),
            AboutAccessibilityStatementItemConfig(statementConfig: acessibilityStatement),
        ]

        self.listItemConfigurations = listItemConfigurations + internalItemsConfig
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

            AboutApplicationInformation(applicationInformation: applicationInformation)
                .padding(.all, ODSSpacing.m)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)

            AboutListItems(configurations: listItemConfigurations)
                .padding(.bottom, ODSSpacing.s)
        }
        .listStyle(.plain)
        .navigationTitle(°°"modules.about.title")
        .navigationBarTitleDisplayMode(.large)
        .background(ODSInternalColor.primaryBackground.color)
    }
}
