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

// ============================================
// MARK: - Accessible Navigation Title Modifier
// ============================================

/// `ViewModifier` which defines a navigation title for the calling `View` and also uses `UIAccessibility` to notify for screen changed.
struct AccessibleNavigationTitleModifier: ViewModifier {

    let title: String
    let deadline: DispatchTime

    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    UIAccessibility.post(notification: .screenChanged, argument: title)
                }
            }
    }
}

// =========================================
// MARK: - Request Accessible Focus Modifier
// =========================================

struct RequestAccessibleFocusModifier: ViewModifier {

    @AccessibilityFocusState var requestFocus: Bool
    let deadline: DispatchTime

    func body(content: Content) -> some View {
        content.onAppear {
            // Voice Over gives focus to some random item in the middle of the screen in the list, need to move focus
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                requestFocus = true
            }
        }
    }
}
