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


public struct OpacitySementicTokens {
    public init(transparent: OpacityRaw, weaker: OpacityRaw, weak: OpacityRaw, medium: OpacityRaw, emphasis: OpacityRaw, opaque: OpacityRaw) {
        self.transparent = transparent
        self.weaker = weaker
        self.weak = weak
        self.medium = medium
        self.emphasis = emphasis
        self.opaque = opaque
    }
    
    public var transparent: OpacityRaw
    public var weaker: OpacityRaw
    public var weak: OpacityRaw
    public var medium: OpacityRaw
    public var emphasis: OpacityRaw
    public var opaque: OpacityRaw
}

public enum OpacityRaw: Double {
   case opacity0 = 0.0
   case opacity100 = 0.04
   case opacity200 = 0.08
   case opacity300 = 0.16
   case opacity400 = 0.24
   case opacity500 = 0.32
   case opacity600 = 0.48
   case opacity700 = 0.64
   case opacity800 = 0.88
   case opacity900 = 1
}

// ========================
// MARK: - ODS Color Palette
// =========================

public typealias ODSColorPalette = [ODSColorDecription]

// =================
// MARK: - ODS Theme
// =================

/// Defines elements for an ODS Theme.
/// Default values are provided to define a `Default` fake theme
public struct ODSTheme: Identifiable, Hashable {

    // =======================
    // MARK: Stored Properties
    // =======================

    public var name: String
    public var colorPalette: ODSColorPalette
    public var componentColors: ODSComponentColors
    public var font: (_ style: ODSFontStyle) -> Font
    public var bundle: Bundle
    public var opacitySementicTokens: OpacitySementicTokens

    // ==================
    // MARK: Initializers
    // ==================

    public init() {
        name = "Default"

        opacitySementicTokens = .init(
            transparent: .opacity0,
            weaker: .opacity100,
            weak: .opacity200,
            medium: .opacity500,
            emphasis: .opacity700,
            opaque: .opacity900)
    
        colorPalette = ODSColorPalette()

        componentColors = ODSComponentColors()
        font = { style in
            switch style {
            case .headlineL:
                return Font.largeTitle.bold()
            case .titleL:
                return Font.title.bold()
            case .titleM:
                return Font.title2.bold()
            case .titleS:
                return Font.title3.bold()
            case .headlineS:
                return Font.headline.bold()
            case .bodyLBold:
                return Font.body.bold()
            case .bodyLRegular:
                return Font.body
            case .bodyM:
                return Font.callout
            case .bodyS:
                return Font.subheadline.bold()
            case .labelL:
                return Font.footnote
            case .labelMBold:
                return Font.caption.bold()
            case .labelMRegular:
                return Font.caption
            case .labelS:
                return Font.caption2
            }
        }

        bundle = Bundle.ods
    }

    // ==================
    // MARK: Color access
    // ==================

    func color(_ assetName: String) -> Color? {
        colorPalette.first { $0.assetName == assetName }?.color
    }

    func color(_ name: String, for colorScheme: ColorScheme) -> Color? {
        colorPalette.first { $0.name(for: colorScheme) == name }?.color
    }

    // ==================
    // MARK: Identifiable
    // ==================

    public var id: String {
        name
    }

    // ==============
    // MARK: Hashable
    // ==============

    public static func == (lhs: ODSTheme, rhs: ODSTheme) -> Bool {
        lhs.name == rhs.name
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
