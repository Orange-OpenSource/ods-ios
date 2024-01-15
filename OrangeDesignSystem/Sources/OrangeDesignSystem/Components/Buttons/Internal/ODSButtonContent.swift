//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
