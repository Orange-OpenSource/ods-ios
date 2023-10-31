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
            case .largeTitle:
                return Font.largeTitle.bold()
            case .title1:
                return Font.title.bold()
            case .title2:
                return Font.title2.bold()
            case .title3:
                return Font.title3.bold()
            case .headline:
                return Font.headline.bold()
            case .bodyRegular:
                return Font.body
            case .bodyBold:
                return Font.body.bold()
            case .callout:
                return Font.callout
            case .subhead:
                return Font.subheadline.bold()
            case .footnote:
                return Font.footnote
            case .caption1Regular:
                return Font.caption
            case .caption1Bold:
                return Font.caption.bold()
            case .caption2:
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
