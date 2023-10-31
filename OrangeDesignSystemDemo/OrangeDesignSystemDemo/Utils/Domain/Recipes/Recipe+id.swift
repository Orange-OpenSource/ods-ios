//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

extension Recipe: Identifiable {
    /// Id to identify the recipe in RecipeBook
    var id: String {
        title + subtitle + description + iconName
    }
}
