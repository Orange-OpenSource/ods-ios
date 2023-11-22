//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

/// Simple struct for logs in _Xcode_ outputs
struct ODSLogger {
    private init() {}

    private static let bullet: String = "💫"
    private static let prefix: String = "\(bullet) OrangeDesignSystem"

    static func debug(_ message: String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line)
    {
        print("\(prefix):debug: 🪲 \(file)/\(function)/\(line)" + message)
    }

    static func warning(_ message: String,
                        file: StaticString = #file,
                        function: StaticString = #function,
                        line: UInt = #line)
    {
        print("\(prefix):warning ⚠️ " + message)
    }

    static func error(_ message: String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line)
    {
        print("\(prefix):error 💥 " + message)
    }
}
