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

import SwiftUI

struct AboutPrivacyPolicyEntity: View {

    let policy: ODSPrivacyPolicy

    @State var showSafari = false

    var body: some View {
        switch policy {
        case .colapsable(let policy):
            NavigationLink(ODSListStandardItemModel(title: "Privacy Policy")) {
                ColapsablePrivacyPolicy(policy: policy)
            }
            .padding(.horizontal, ODSSpacing.m)

        case .webview(let source):
            NavigationLink(ODSListStandardItemModel(title: "Privacy Policy")) {
                WebView(source: source)
            }
            .padding(.horizontal, ODSSpacing.m)
        }
    }
}

struct ColapsablePrivacyPolicy: View {

    let policy: ODSStructuredPrivacyPolicy

    var body: some View {
        ForEach(policy.entities, id: \.id) { entity in
            DisclosureGroup(entity.title) {
                WebView(source: .html(entity.description))
            }
        }
    }
}
