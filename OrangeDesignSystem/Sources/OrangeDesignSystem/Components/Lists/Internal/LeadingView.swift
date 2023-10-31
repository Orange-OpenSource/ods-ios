//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
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
