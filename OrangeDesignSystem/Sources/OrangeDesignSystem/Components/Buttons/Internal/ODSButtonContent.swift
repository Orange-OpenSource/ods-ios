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

// MARK: Content of ODS buttons
struct ODSButtonContent: View {

    // =======================
    // MARK: Stored properties
    // =======================

    let text: Text
    let image: Image?

    // =================
    // MARK: Initiliazer
    // =================

    init(_ text: Text, image: Image? = nil) {
        self.text = text
        self.image = image
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        HStack(alignment: .center, spacing: ODSSpacing.s) {
            if let image = image {
                // /!\ Set to 17 because the size of system font for body is 17
                ODSIcon(image, size: 17)
            }

            text.odsFont(.bodyLBold)
        }
    }
}

#if DEBUG
struct ODSButtonContent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ODSButtonContent(Text("Text"), image: Image(systemName: "wrench"))
                .background(.red)
            ODSButtonContent(Text("Text"), image: Image(systemName: "wrench"))
                .background(.blue)
            ODSButtonContent(Text("Text"), image: Image(systemName: "wrench"))
                .background(.red)
        }
        .background(.green)
    }
}
#endif
