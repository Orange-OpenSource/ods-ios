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

import SwiftUI

/// Use the about module to display application name, software version,
/// legal data protection, privacy, accessibilty statement,
/// and terms of service compliance information.
///
/// It is also configurable to add some additional items to display
/// pages related to the service provided by the application
/// (i.e. settings, tutorials, ...)
///
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
    ///     - headerIllustration: Image of the illustration at the top of the screen.
    ///     - applicationInformation: (Mandatory) Information about the application.
    ///     - privacyPolicy: (Mandatory) The privacy policy of the application.
    ///     - acessibilityStatement: (Mandatory) The configuration to access the report of the accessibility statement.
    ///     - termsOfService: (Mandatory) A view builder to provide the terms of service (could be a webview, native screen, ...)
    ///     - listItemConfigurations: Configuration to add items in the list. The items are ordered according to the priority set in configutation.
    ///
    ///  @Remark: Privacy Policy, accessibility statement and terms of service pages are
    ///  mandatory in this module. To access those pages, associated items are automatically
    ///  added in the list. They are ordered according to their priority defined by:
    ///  __ODSAboutListItemPriority.privacyPolicy__, __ODSAboutListItemPriority.termOfService__, __ODSAboutListItemPriority.accessibilityStatement__.
    ///  If custom items should be placed before those, configures them with lower priority.
    ///
    public init(headerIllustration: Image = Image("il_about", bundle: Bundle.ods),
                applicationInformation: ODSAboutApplicationInformation,
                privacyPolicy: ODSPrivacyPolicy,
                acessibilityStatement: ODSAboutAccessibilityStatement,
                @ViewBuilder termsOfService: @escaping () -> TermsOfService,
                listItemConfigurations: [ODSAboutListItemConfig]) {
        self.headerIllustration = headerIllustration
        self.applicationInformation = applicationInformation

        let internalItemsConfig = [
            AboutPrivacyPolicyItem(policy: privacyPolicy) as ODSAboutListItemConfig,
            AboutTermOfServiceItem(termsOfService: termsOfService) as ODSAboutListItemConfig,
            AboutAccessibilityStatementItemConfig(statementConfig: acessibilityStatement) as ODSAboutListItemConfig
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

            Group {
                AboutApplicationInformation(applicationInformation: applicationInformation)
                    .padding(.vertical, ODSSpacing.m)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                AboutListItems(configurations: listItemConfigurations)
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.bottom, ODSSpacing.s)
        }
        .listStyle(.plain)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.large)
        .background(ODSInternalColor.primaryBackground.color)
    }
}
