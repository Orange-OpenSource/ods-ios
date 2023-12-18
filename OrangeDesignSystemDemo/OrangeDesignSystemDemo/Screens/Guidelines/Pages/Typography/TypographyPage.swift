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
        case .headlineL:
            return "Headline L"
        case .titleL:
            return "Title L"
        case .titleM:
            return "Title M"
        case .titleS:
            return "Title S"
        case .headlineS:
            return "Headline S"
        case .bodyLRegular:
            return "Body L Regular"
        case .bodyLBold:
            return "Body L Bold"
        case .bodyM:
            return "Body M"
        case .bodyS:
            return "Body S"
        case .labelL:
            return "Label L"
        case .labelMRegular:
            return "Label M Regular"
        case .labelMBold:
            return "Label M Bold"
        case .labelS:
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
