//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

public typealias ODSColorPalette = [ODSColorDecription]

///
/// Defines elements for an ODS Theme.
/// Default values are provided to define a `Default` fake theme
///
public struct ODSTheme: Identifiable, Hashable {

    // =======================
    // MARK: Stored Properties
    // =======================

    public var name: String
    public var colorPalette: ODSColorPalette
    public var componentColors: ODSComponentColors
    public var font: (_ style: ODSFontStyle) -> Font

    // ==================
    // MARK: Initializers
    // ==================

    public init() {
        name = "Default"
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
