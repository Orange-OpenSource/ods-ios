//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

// TODO: To be completed
public enum ODSPrivacyPolicy {
    case colapsable(ODSStructuredPrivacyPolicy)
    case webview(ODSWebContentSource)
}

public enum ODSWebContentSource {
    case url(URL)
    case html(String)
}

public struct ODSStructuredPrivacyPolicy: Codable {
    let entities: [ODSPrivacyPolicyEntity]

    public init(entities: [ODSPrivacyPolicyEntity]) {
        self.entities = entities
    }
}

public struct ODSPrivacyPolicyEntity: Codable, Identifiable {
    let title: String
    let description: String

    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    public var id: String {
        title
    }
}
