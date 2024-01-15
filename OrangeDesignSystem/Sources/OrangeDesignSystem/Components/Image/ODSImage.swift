//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

///
/// As image can be loaded from resources (sync) or
/// from url (Async), this desplays image accrding to the
/// source __ODSImage.Source__.
///
/// For Async image, until the image loads, the view displays a standard placeholder that fills the available space.
/// For more detail see __AsyncImage__.
///
public struct ODSImage: View {

    // ======================
    // MARK: Store Properties
    // ======================

    public enum Source {
        case image(Image)
        case asyncImage(URL, Image)

        public init(url: URL, placeholder: Image = Image("ods_empty", bundle: Bundle.ods)) {
            self = .asyncImage(url, placeholder)
        }
    }

    let source: Source

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        switch source {
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

        case let .image(image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}
