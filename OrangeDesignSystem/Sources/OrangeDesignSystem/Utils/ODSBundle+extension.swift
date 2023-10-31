//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

extension Bundle {
    public static var ods: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: ODSBundleResource.self)
        #endif
    }
}

#if SWIFT_PACKAGE
#else
class ODSBundleResource {}
#endif
