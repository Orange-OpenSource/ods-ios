//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
// 
// This software is distributed under the MIT licence,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
// 
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System 
//

import Foundation
import SwiftUI

/// `ViewModifier` which defines a navigation title for the calling `View` and also use `UIAccessibility` to notify for screen changed.
/// The title can be a wording key which will be localized.
struct AccssibleNavigationTitleModifier: ViewModifier {

    private let title: String

    init(title: String) {
        self.title = title.localized()
    }

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    UIAccessibility.post(notification: .screenChanged, argument: title)
                }
            }
    }
}
