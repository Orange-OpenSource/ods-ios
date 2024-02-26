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

struct LeadingView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let element: ODSListItem.Leading
    let height: CGFloat
    let width: CGFloat = 44
    let wideWidth: CGFloat = 88

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        switch element {
        case let .icon(image):
            image.renderingMode(.template)
        case let .appIcon(source):
            ODSImage(source: source)
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
        case let .circularImage(source):
            ODSImage(source: source)
                .frame(width: width, height: height)
                .clipShape(Circle())
        case let .squareImage(source):
            ODSImage(source: source)
                .frame(width: width, height: height)
                .clipShape(Rectangle())
        case let .wideImage(source):
            ODSImage(source: source)
                .frame(width: wideWidth, height: height)
                .clipShape(Rectangle())
        }
    }
}
