//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct TypographyPageDescription: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let fontStyles = ODSFontStyle.allCases

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.m) {
            ForEach(fontStyles, id: \.rawValue) { fontStyle in
                VStack(alignment: .leading, spacing: ODSSpacing.xs) {
                    Text(fontStyle.description)
                        .odsFont(fontStyle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("style: \(fontStyle.rawValue)").font(.system(.caption, design: .monospaced))
                }
                .accessibilityElement()
                .accessibilityLabel("a11y.typography_details" <- [fontStyle.description, fontStyle.rawValue])
            }
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.bottom, ODSSpacing.m)
    }
}

// MARK: Font syle description
extension ODSFontStyle {
    fileprivate var description: String {
        switch self {
        case .largeTitle:
            return "Large Title"
        case .title1:
            return "Title 1"
        case .title2:
            return "Title 2"
        case .title3:
            return "Title 3"
        case .headline:
            return "Headline"
        case .bodyRegular:
            return "Body (regular)"
        case .bodyBold:
            return "Body (bold)"
        case .callout:
            return "Callout"
        case .subhead:
            return "Subheadline"
        case .footnote:
            return "Footnote"
        case .caption1Regular:
            return "Caption 1 (regular)"
        case .caption1Bold:
            return "Caption 1 (bold)"
        case .caption2:
            return "Caption 2"
        }
    }
}

#if DEBUG
struct FontList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            TypographyPageDescription().environmentObject(ScreenState()).preferredColorScheme($0)
        }
    }
}
#endif
