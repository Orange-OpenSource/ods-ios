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

import OrangeDesignSystem
import SwiftUI

struct SpacingsPageDescription: View {

    // ======================
    // MARK: Store properties
    // ======================

    private let spacings = Spacing.allCases
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.none) {
            ForEach(spacings, id: \.rawValue) { spacing in
                SpacingItem(spacing: spacing)
            }
            .padding(.horizontal, ODSSpacing.m)
        }
        .padding(.bottom, ODSSpacing.m)
        .accessibilityRespondsToUserInteraction(false) // Switch Control must not focus this view
    }
}

private struct SpacingItem: View {

    // ======================
    // MARK: Store properties
    // ======================

    let spacing: Spacing

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.s) {

            HStack(spacing: ODSSpacing.m) {
                SpacingVisual(spacing: spacing)

                VStack(alignment: .leading) {
                    Text(spacing.name).odsFont(.bodyLRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(spacing.rawValue, specifier: "%.0f") px").odsFont(.bodyLRegular)
                }

                Spacer()

                Text(spacing.ratio)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .odsFont(.bodyLRegular)
            }
            .padding(.top, ODSSpacing.s)

            Divider()
        }
        .accessibilityElement()
        .accessibilityLabel(spacing.accessibilityLabel)
    }
}

private struct SpacingVisual: View {

    // ======================
    // MARK: Store properties
    // ======================

    let spacing: Spacing

    // ====================
    // MARK: Computed value
    // ====================

    private var spacingWidth: Double {
        spacing == .none ? spacing.rawValue + 1 : spacing.rawValue
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("spacingBackground"))
                .frame(height: 16, alignment: .topLeading)

            Rectangle()
                .foregroundColor(Color("supportingIndicator"))
                .frame(width: spacingWidth, alignment: .center)
        }
        .frame(width: 60, height: 50)
        .background(Color(UIColor.tertiarySystemFill))
    }
}

private enum Spacing: Double, CaseIterable {
    case none
    case xs
    case s
    case m
    case l
    case xl
    case xxl

    var rawValue: Double {
        switch self {
        case .none: return ODSSpacing.none
        case .xs: return ODSSpacing.xs
        case .s: return ODSSpacing.s
        case .m: return ODSSpacing.m
        case .l: return ODSSpacing.l
        case .xl: return ODSSpacing.xl
        case .xxl: return ODSSpacing.xxl
        }
    }

    var name: String {
        switch self {
        case .none: return "spacing-none"
        case .xs: return "spacing-xs"
        case .s: return "spacing-s"
        case .m: return "spacing-m"
        case .l: return "spacing-l"
        case .xl: return "spacing-xl"
        case .xxl: return "spacing-xxl"
        }
    }

    var ratio: String {
        switch self {
        case .none: return "Ratio -"
        case .xs: return "Ratio 0.5"
        case .s: return "Ratio 1"
        case .m: return "Ratio 2"
        case .l: return "Ratio 3"
        case .xl: return "Ratio 4"
        case .xxl: return "Ratio 5"
        }
    }

    var ratioSpokenValue: String {
        switch self {
        case .none: return "0"
        case .xs: return "0.5"
        case .s: return "1"
        case .m: return "2"
        case .l: return "3"
        case .xl: return "4"
        case .xxl: return "5"
        }
    }

    var accessibilityLabel: String {
        "a11y.spacings_details" <- ["\(Int(rawValue)) \(rawValue < 2 ? "pixel" : "pixels")", name, ratioSpokenValue]
    }
}
