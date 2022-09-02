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

import SwiftUI
import UIKit

// ==================
// MARK: - ODS Colors
// ==================

/// Defines all colors in the Orange Brand
public enum ODSColor: String {

    // MARK: - CORE
    case coreOrange // 2 tints (Dark & Light)
    case coreWhite
    case coreBlack
    case coreObsGrey

    // MARK: - FUNCTIONAL
    case functionalPositive // 2 tints (Dark & Light)
    case functionalNegative // 2 tints (Dark & Light)
    case functionalInfo // 2 tints (Dark & Light)
    case functionalAlert // 2 tints (Dark & Light)

    // MARK: - SUPPORTING
    case supportingBlue100
    case supportingBlue200
    case supportingBlue300
    case supportingYellow100
    case supportingYellow200
    case supportingYellow300
    case supportingGreen100
    case supportingGreen200
    case supportingGreen300
    case supportingPurple100
    case supportingPurple200
    case supportingPurple300
    case supportingPink100
    case supportingPink200
    case supportingPink300

    // MARK: - TMP
    case componentBackground
    case componentBackground2
    case primaryBackground

    /// Get the color values from resources with its name
    public var color: Color {
        return Color(rawValue, bundle: Bundle.ods)
    }
}
