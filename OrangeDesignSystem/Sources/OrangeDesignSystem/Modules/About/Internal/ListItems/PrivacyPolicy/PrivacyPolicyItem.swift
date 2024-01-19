//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

struct AboutPrivacyPolicyItem: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let icon: Image
    let target: ODSAboutListItemTarget
    let priority: ODSAboutListItemPriority

    // =================
    // MARK: Initializer
    // =================

    init(policy: ODSPrivacyPolicy) {
        title = °°"modules.about.privacy_policy.title"
        icon = Image("ic_dataProtection", bundle: Bundle.ods)
        priority = .privacyPolicy
        target = .destination(AnyView(AboutPrivacyPolicy(policy: policy)))
    }
}

struct AboutPrivacyPolicy: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let policy: ODSPrivacyPolicy

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch policy {
        case let .colapsable(policy):
            ColapsablePrivacyPolicy(policy: policy)
        case let .webview(source):
            WebView(source: source)
        }
    }
}

struct ColapsablePrivacyPolicy: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let policy: ODSStructuredPrivacyPolicy

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ForEach(policy.entities, id: \.id) { entity in
            DisclosureGroup(entity.title) {
                WebView(source: .html(entity.description))
            }
        }
    }
}
