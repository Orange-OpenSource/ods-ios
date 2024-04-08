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

import Flow
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
                .odsFont(.headlineS)
                .accessibilityAddTraits(.isHeader)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, ODSSpacing.m)

            switch placement {
            case .carousel:
                carouselContent
            case .stacked:
                stackedContent
            }
        }
        .accessibilityLabel(title ?? Text(""))
    }

    // =====================
    // MARK: Private Helpers
    // =====================

    private func content(for chip: ODSChoiceChip<Value>) -> some View {
        ODSChoiceChipView(chip: chip, selected: selection.wrappedValue == chip.value) {
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
                .accessibilityElement(children: .contain)
                .padding(.leading, ODSSpacing.m)
            }
        }
    }

    @State private var finalSize: CGSize = .zero

    @ViewBuilder
    private var stackedContent: some View {
        if #available(iOS 16.0, *) {
            HFlow(alignment: .top, spacing: ODSSpacing.s) {
                ForEach(chips, id: \.value) { chip in
                    content(for: chip)
                }
            }
            .accessibilityElement(children: .contain)
            .padding(.horizontal, ODSSpacing.m)
        } else {
            var width = CGFloat.zero
            var height = CGFloat.zero
            VStack {
                GeometryReader { geo in
                    ZStack(alignment: .topLeading) {
                        ForEach(chips, id: \.value) { chip in
                            content(for: chip)
                                .padding(.top, ODSSpacing.xs)
                                .padding(.trailing, ODSSpacing.xs)
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
                    .readSize { size in
                        finalSize = size
                    }
                }
            }
            .frame(height: finalSize.height)
            .padding(.horizontal, ODSSpacing.m)
            .accessibilityElement(children: .contain)
        }
    }
}
