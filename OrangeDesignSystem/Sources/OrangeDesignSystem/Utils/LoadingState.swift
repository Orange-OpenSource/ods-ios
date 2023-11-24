//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

/// Enumeration which allows to deal with loading states of views so as to display or not a skeleton, get data or error.
/// Should be used when the view is loading data or waiting for a request response and view model results for example.
/// - Parameters:
///    - Payload: Genreric type of data (picked from backend request for example)
///    - Error: Some error instead of a payload
enum LoadingState<Payload, Error> {

    /// Waiting for some data
    case loading

    /// Data have been loaded
    case loaded(_ payload: Payload)

    /// And error occured whiile loading data
    case error(_ error: Error)
}
