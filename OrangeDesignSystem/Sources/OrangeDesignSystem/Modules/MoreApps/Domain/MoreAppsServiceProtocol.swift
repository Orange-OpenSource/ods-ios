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

protocol MoreAppsServiceProtocol {

    /// - Parameter repository: The object to use to get the raw data from a feeder
    init(repository: MoreAppsRepositoryProtocol)

    /// Supposed to be async method to return the apps lists or to throw some error, using the given `MoreAppsRepositoryProtocol`
    func availableAppsList() async throws -> MoreAppsList
}
