//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
