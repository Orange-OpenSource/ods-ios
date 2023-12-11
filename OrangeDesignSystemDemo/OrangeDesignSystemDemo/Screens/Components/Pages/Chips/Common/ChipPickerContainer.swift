//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

enum ChipPickerPlacement {
    case carousel
    case stacked
}

struct ChipPickerContainer<Value, ValueContent>: View where Value: Hashable, ValueContent: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let title: Text?
    let placement: ChipPickerPlacement
    let values: [Value]
    @ViewBuilder
    let valueContent: (_ value: Value) -> ValueContent

    // =================
    // MARK: Initializer
    // =================

    init(title: Text? = nil, placement: ChipPickerPlacement, values: [Value], @ViewBuilder valueContent: @escaping (Value) -> ValueContent) {
        self.title = title
        self.placement = placement
        self.values = values
        self.valueContent = valueContent
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.xs) {
            title?
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ODSSpacing.m)
            switch placement {
            case .carousel:
                carouselContent
            case .stacked:
                stackedContent
            }
        }
    }

    @ViewBuilder
    private var stackedContent: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        var lastHeight = CGFloat.zero

        GeometryReader { geo in
            ZStack(alignment: .topLeading) {
                ForEach(values, id: \.hashValue) { value in
                    valueContent(value)
                        .padding(.all, ODSSpacing.xs)
                        .alignmentGuide(.leading) { dimension in
                            if abs(width - dimension.width) > geo.size.width {
                                width = 0
                                height -= dimension.height
                            }
                            let result = width
                            if value == values.last! {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            lastHeight = dimension.height
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            if value == values.last! {
                                height = 0
                            }
                            return result
                        }
                }
            }
        }
        .frame(height: lastHeight + ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.xs)
        .padding(.horizontal, ODSSpacing.s)
    }

    @ViewBuilder
    private var carouselContent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: ODSSpacing.s) {
                ForEach(values, id: \.hashValue) { value in
                    valueContent(value)
                }
            }
            .padding(.leading, ODSSpacing.m)
        }
    }
}
