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

import Foundation
import UIKit

extension UIApplication {

    /// Get the view controll at top level of the current active screen.
    /// Usefull to display a sheet over all.
    public var topViewController: UIViewController? {
        let scene = connectedScenes.first { $0.activationState == .foregroundActive }

        var topViewController = (scene as? UIWindowScene)?.keyWindow?.rootViewController

        while topViewController?.presentedViewController != nil {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController
    }
}
