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
import XCTest

extension XCTestCase {

    static func stubPath(for name: String, ofType ext: String, inBundleOf anyClass: AnyClass) -> String {
        guard let path = Bundle(for: anyClass).path(forResource: name, ofType: ext) else {
            fatalError("Stub file '\(name).\(ext)' not found!")
        }
        return path
    }

    static func stubURL(for name: String, ofType ext: String, inBundleOf anyClass: AnyClass) -> URL {
        guard let url = Bundle(for: anyClass).url(forResource: name, withExtension: ext) else {
            fatalError("Stub file '\(name).\(ext)' not found!")
        }
        return url
    }
}
