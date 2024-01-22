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

struct AboutTermOfServiceItem: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let icon: Image
    let target: ODSAboutListItemTarget
    let priority: ODSAboutListItemPriority

    init<TermsOfService>(@ViewBuilder termsOfService: () -> TermsOfService) where TermsOfService: View {
        title = °°"modules.about.terms_of_service.title"
        icon = Image("ic_calendarEventInfo", bundle: Bundle.ods)
        priority = .termOfService
        target = .destination(AnyView(termsOfService()))
    }
}
