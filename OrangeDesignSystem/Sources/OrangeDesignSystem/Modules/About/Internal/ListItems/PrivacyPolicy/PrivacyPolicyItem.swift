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
        priority = ODSAboutListItemPriority.privacyPolicy
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
