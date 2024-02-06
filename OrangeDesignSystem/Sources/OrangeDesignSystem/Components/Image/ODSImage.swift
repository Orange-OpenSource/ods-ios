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

/// As image can be loaded from resources (sync) or from url (Async), this desplays image according to the
/// source __ODSImage.Source__.
///
/// For Async image, until the image loads, the view displays a standard placeholder that fills the available space.
/// For more detail see __AsyncImage__.
/// Async image can also be cached, meaning if the request to load the image fails some cache if existing ill be used to load the previously fetched data.
public struct ODSImage: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let source: Source

    public enum Source {
        case image(Image)
        case asyncImage(URL, Image)
        case cachedAsyncImage(URL, Image)

        public init(url: URL, placeholder: Image = Image("ods_empty", bundle: Bundle.ods)) {
            self = .asyncImage(url, placeholder)
        }
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        switch source {
        case let .image(image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)

        case let .asyncImage(url, placeHolder):
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                placeHolder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }

        case let .cachedAsyncImage(url, placeHolder):
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                placeHolder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
