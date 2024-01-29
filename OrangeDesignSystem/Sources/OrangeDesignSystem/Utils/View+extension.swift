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

extension View {

    /// Adds a modifier to the current `View` so as to define a naivgation title using the current `title`
    /// and also send a notification for accessibility layers for a change of screen when appeared.
    /// - Parameter title: The navigation title
    /// - Returns View: The view with a new modifier
    public func odsNavigationTitle(_ title: String) -> some View {
        self.modifier(AccssibleNavigationTitleModifier(title: title))
    }
}
