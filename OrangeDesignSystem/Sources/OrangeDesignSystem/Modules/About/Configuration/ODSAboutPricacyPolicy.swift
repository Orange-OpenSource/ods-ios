//
// MIT License
// Copyright (c) 2021 Orange
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the  Software), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

import Foundation

/// To be completed
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
