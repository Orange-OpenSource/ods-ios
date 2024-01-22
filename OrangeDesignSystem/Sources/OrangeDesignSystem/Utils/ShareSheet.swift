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

import SwiftUI

enum ShareSheet {
    /// Use to display a share sheet on the current active screen.
    ///
    /// - Parameters:
    ///     - content: The content displayed in the body of a mail.
    ///     - subject; The subject of the mail.
    ///
    static func show(content: String, subject: String = "", url: URL? = nil) {
        let item = ShareItem(content: content, mailSubject: subject)
        var items: [Any] = [item]
        if let url = url {
            items.append(url)
        }
        let av = UIActivityViewController(activityItems: items, applicationActivities: nil)
        UIApplication.shared.topViewController?.present(av, animated: true, completion: nil)
    }
}

private final class ShareItem: NSObject, UIActivityItemSource {

    let content: String
    let mailSubject: String

    init(content: String, mailSubject: String) {
        self.content = content
        self.mailSubject = mailSubject
        super.init()
    }

    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        content
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        content
    }

    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        mailSubject
    }
}
