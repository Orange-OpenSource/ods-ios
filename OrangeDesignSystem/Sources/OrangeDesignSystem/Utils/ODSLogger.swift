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
import os

/// Simple struct for logs in _Xcode_ outputs
struct ODSLogger {

    private init() {}

    private static let logger = Logger()
    private static let bullet: String = "💫"
    private static let prefix: String = "\(bullet) OrangeDesignSystem"

    static func debug(_ message: String) {
        #if DEBUG
        logger.debug("\(prefix):debug: 🪲 \(message)")
        #endif
    }

    static func log(_ message: String) {
        #if DEBUG
        logger.log("\(prefix): \(message)")
        #endif
    }

    static func info(_ message: String) {
        logger.info("\(prefix):info: ℹ️ \(message)")
    }

    static func warning(_ message: String) {
        logger.warning("\(prefix):warning: ⚠️ \(message)")
    }

    static func error(_ message: String) {
        logger.error("\(prefix):error: 💥 \(message)")
    }
}
