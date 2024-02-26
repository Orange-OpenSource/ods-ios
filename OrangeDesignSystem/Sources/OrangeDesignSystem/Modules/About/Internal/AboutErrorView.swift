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

struct AboutErrorView: View {

    private let text: Text

    init(text: Text = Text("modules.about.error.generic_message".🌐)) {
        self.text = text
    }

    var body: some View {
        ODSEmptyStateView(title: text, image: Image("il_yoga_man", bundle: Bundle.ods))
    }
}
