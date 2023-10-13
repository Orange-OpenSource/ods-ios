/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import DeclarationAccessibility
import SwiftUI

struct AboutAccessibilityStatementItemConfig: ODSAboutListItemConfig {

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

    init(statementConfig: ODSAboutAccessibilityStatement) {
        title = "modules.about.accessibility_statement.title".localized()
        icon = Image("ic_accessibility", bundle: Bundle.ods)
        priority = .accessibilityStatement
        target = .destination(AnyView(
            DeclarationView(xmlFileName: statementConfig.fileName,
                            selectedTheme: .orange,
                            url: statementConfig.reportDetail.absoluteString)
            ))
    }
}
