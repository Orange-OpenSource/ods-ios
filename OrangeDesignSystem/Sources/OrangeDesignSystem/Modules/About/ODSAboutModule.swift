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

public struct ODSAboutModule<LegalInformation, TermOfService>: View where LegalInformation: View, TermOfService: View {

    // =======================
    // MARK: Stored properties
    // =======================

    private let headerIllustration: Image
    private let applicationInformation: ODSAboutApplicationInformation
    private let applicationNewsPath: String?
    private let privacyPolicy: ODSPrivacyPolicy
    private let termOfService: () -> TermOfService
    private let legalInformation: LegalInformation
    private let customItems: [ODSAboutCustomListItem]

    // ==================
    // MARK: Initializers
    // ==================

    /// Initializes the about module.
    ///
    /// - Parameters:
    ///     - headerIllustration: Image of the illustration at the top of the screen
    ///     - applicationInformation: Information about the application set in the area describing it.
    ///     - applicationNewsPath: (Optional) Path to the json file containing the news history of all releases of the application.
    ///     - privacyPolicy: The privacy policy of the application
    ///     - termsOfService: (Mandatory) A view builder to provide the terms of service (could be a webview, native screen, ...)
    ///     - legalInformation: (Optional) A view builder to provide legal information (could be a webview, native screen, ...)
    ///     - customItems: The custom items to be added at the end of the list.
    ///
    public init(headerIllustration: Image = Image("ic_about_image", bundle: Bundle.ods),
                applicationInformation: ODSAboutApplicationInformation,
                applicationNewsPath: String? = nil,
                privacyPolicy: ODSPrivacyPolicy,
                termsOfService: @escaping () -> TermOfService,
                legalInformation: @escaping () -> LegalInformation = { EmptyView() },
                customItems: [ODSAboutCustomListItem] = []) {
        self.headerIllustration = headerIllustration
        self.applicationInformation = applicationInformation
        self.applicationNewsPath = applicationNewsPath
        self.privacyPolicy = privacyPolicy
        self.legalInformation = legalInformation()
        self.termOfService = termsOfService
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
                AboutApplicationInformation(applicationInformation: applicationInformation)
                    .padding(.vertical, ODSSpacing.m)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                AboutPrivacyPolicy(policy: privacyPolicy)

                if let applicationNewsPath = applicationNewsPath {
                    AboutListItem(
                        title: "App News",
                        icon: Image("ic_taskList", bundle: Bundle.ods),
                        destination: AnyView(AboutReleaaseDescriptionView(applicationNewsPath: applicationNewsPath))
                    )
                }

                AboutListItem(
                    title: "Term of Service",
                    icon: Image("ic_calendarEventInfo", bundle: Bundle.ods),
                    destination: AnyView(termOfService()))

                if legalInformation is EmptyView == false {
                    AboutListItem(title: "Legal information", icon: Image("ic_legal", bundle: Bundle.ods), destination: AnyView(legalInformation))
                }

                AboutCustomListItems(items: customItems)
            }
            .padding(.horizontal, ODSSpacing.m)
        }
        .listStyle(.plain)
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.large)
        .background(ODSInternalColor.primaryBackground.color)
    }
}
