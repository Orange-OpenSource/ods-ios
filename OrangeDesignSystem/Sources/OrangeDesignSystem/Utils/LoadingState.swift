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

/// Enumeration which allows to deal with loading states of views so as to display or not a skeleton, get data or error.
/// Should be used when the view is loading data or waiting for a request response and view model results for example.
/// - Parameters:
///    - Payload: Genreric type of data (picked from backend request for example)
///    - Error: Some error instead of a payload
enum LoadingState<Payload, Error> {

    /// No fetch started yet
    case idle
    
    /// Waiting for some data
    case loading

    /// Data have been loaded
    case loaded(_ payload: Payload)

    /// And error occured whiile loading data
    case error(_ error: Error)
}
