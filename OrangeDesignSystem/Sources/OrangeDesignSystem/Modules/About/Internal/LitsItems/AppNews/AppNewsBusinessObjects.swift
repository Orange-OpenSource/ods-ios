//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

// =================================
// MARK: - About Release Description
// =================================

struct AboutReleaseDescription: Decodable {
    let version: String
    let date: Date
    let news: String
}
