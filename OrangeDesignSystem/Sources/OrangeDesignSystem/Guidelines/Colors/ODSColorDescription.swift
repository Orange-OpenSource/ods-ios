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

import Foundation
import SwiftUI

public struct ODSColorDecription {

    // =======================
    // MARK: Stored Properties
    // =======================

    public let assetName: String
    public let bundle: Bundle
    public let nameForLightScheme: String?
    public let nameForDarkScheme: String?

    // =================
    // MARK: Initializer
    // =================

    public init(
        assetName: String,
        bundle: Bundle,
        nameForLightScheme: String? = nil,
        nameForDarkScheme: String? = nil
    ) {
        self.assetName = assetName
        self.bundle = bundle
        self.nameForLightScheme = nameForLightScheme
        self.nameForDarkScheme = nameForDarkScheme
    }

    // =============
    // MARK: Helpers
    // =============

    public var color: Color {
        Color(assetName, bundle: bundle)
    }

    public var uiColor: UIColor {
        UIColor(named: assetName, in: bundle, compatibleWith: nil) ?? .clear
    }

    public func name(for scheme: ColorScheme) -> String? {
        scheme == .light ? nameForLightScheme : nameForDarkScheme
    }
}
