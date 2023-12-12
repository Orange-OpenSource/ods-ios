//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation
import XCTest

extension XCTestCase {

    static func stubPath(for name: String, ofType ext: String, inBundleOf anyClass: AnyClass) -> String {
        guard let url = Bundle(for: anyClass).path(forResource: name, ofType: ext) else {
            fatalError("Stub file '\(name).\(ext)' not found!")
        }
        return url
    }
}
