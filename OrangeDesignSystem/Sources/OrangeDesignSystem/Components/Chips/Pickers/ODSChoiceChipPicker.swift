//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

/// Create a picker by providing the selection type with a binding to get selected element(s).
///
/// An additonnal title can be added above the Picker.
///
public struct ODSChoiceChipPicker<Value>: View where Value: Hashable {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let title: Text?
    private let chips: [ODSChoiceChip<Value>]
    private var selection: Binding<Value>
    private let placement: ODSChipPickerPlacement

    // =================
    // MARK: Initializer
    // =================

    /// Creates a picker which manages a multiple selection that allows no element to be selected.
    ///
    /// - Parameters:
    ///     - title: Optional title above the picker
    ///     - selection: A binding to a property that determines the currently-selected option.
    ///     - chips: All chips describing elements to be displayed.
    ///     - placement: Define the placement of the chips in the picker. By default, chips are placed in a carousel.
    ///
    public init(title: Text? = nil, chips: [ODSChoiceChip<Value>], selection: Binding<Value>, placement: ODSChipPickerPlacement = .carousel) {
        self.title = title
        self.chips = chips
        self.selection = selection
        self.placement = placement
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.s) {
            title?
                .odsFont(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, ODSSpacing.m)

            switch placement {
            case .carousel:
                carouselContent
            case .stacked:
                stackedContent
            }
        }
    }

    // =====================
    // MARK: Private Helpers
    // =====================

    private func content(for chip: ODSChoiceChip<Value>) -> some View {
        return ODSChoiceChipView(chip: chip, selected: selection.wrappedValue == chip.value) {
            selection.wrappedValue = chip.value
        }
    }

    @ViewBuilder
    private var carouselContent: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: ODSSpacing.s) {
                    ForEach(chips, id: \.value) { chip in
                        content(for: chip)
                    }
                }
                .padding(.leading, ODSSpacing.m)
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
                ForEach(chips, id: \.value) { chip in
                    content(for: chip)
                        .padding(.all, ODSSpacing.xs)
                        .alignmentGuide(.leading) { dimension in
                            if abs(width - dimension.width) > geo.size.width {
                                width = 0
                                height -= dimension.height
                            }
                            let result = width
                            if chip.value == chips.last!.value {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            lastHeight = dimension.height
                            return result
                        }
                        .alignmentGuide(.top) { _ in
                            let result = height
                            if chip.value == chips.last!.value {
                                height = 0
                            }
                            return result
                        }
                }
            }
        }
        .padding(.all, ODSSpacing.xs)
        .frame(height: lastHeight + ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.xs)
        .padding(.horizontal, ODSSpacing.s)
    }
}
