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
