//
// MIT License
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

import DeclarationAccessibility
import SwiftUI

struct AboutAccessibilityStatementItemConfig: ODSAboutListItemConfig {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: String
    let icon: Image
    let target: ODSAboutListItemTarget
    let priority: ODSAboutListItemPriority

    // =================
    // MARK: Initializer
    // =================

    init(statementConfig: ODSAboutAccessibilityStatement) {
        title = "Accessibility Statement"
        icon = Image("ic_accessibility", bundle: Bundle.ods)
        priority = .accessibilityStatement
        target = .destination(AnyView(
            DeclarationView(xmlFileName: statementConfig.fileName,
                            selectedTheme: .orange,
                            url: statementConfig.reportDetail.absoluteString)
            ))
    }
}

private struct AccessibilityStatement: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let statementConfig: ODSAboutAccessibilityStatement

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
           
//            Text("The Accessibility statement can be generated using the Orange's V11ydette: https://la-va11ydette.orange.com/")
//                .padding(ODSSpacing.m)
        }
    }
}
