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
import OrangeDesignSystem
import SwiftUI

enum Spacing: Double, CaseIterable {
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
}

struct SpacingList: View {

    let spacings = Spacing.allCases

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {

                Image("Spacing")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(.bottom, ODSSpacing.m)

                Text("Spacing tokens are used to position elements on the screen and layout within components. Spacing tokens can be applied as padding and margins.")
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.m)

                ForEach(spacings, id: \.rawValue) { spacing in
                    SpacingItem(spacing: spacing)
                }
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.bottom, ODSSpacing.xs)
        }
        .navigationTitle("Spacings")
        .navigationViewStyle(.stack)
        .background(ODSColor.primaryBackground.color)
    }
}

struct SpacingItem: View {
    let spacing: Spacing

    var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.s) {

            HStack(spacing: ODSSpacing.m) {
                SpacingVisual(spacing: spacing)

                VStack(alignment: .leading) {
                    Text(spacing.name).odsFont(.bodyRegular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(spacing.rawValue, specifier: "%.0f") px").odsFont(.bodyRegular)
                }

                Spacer()

                Text(spacing.ratio)
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .odsFont(.bodyRegular)
            }
            .padding(.top, ODSSpacing.s)

            Divider()
        }
    }
}

struct SpacingVisual: View {
    let spacing: Spacing

    var spacingWidth: Double {
        spacing == .none ? spacing.rawValue + 1 : spacing.rawValue
    }

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(ODSColor.coreObsGrey.color)
                .frame(height: 16, alignment: .topLeading)

            Rectangle()
                .foregroundColor(ODSColor.supportingBlue200.color)
                .frame(width: spacingWidth, alignment: .center)
        }
        .frame(width: 60, height: 50)
        .background(Color(UIColor.tertiarySystemGroupedBackground))
    }
}
