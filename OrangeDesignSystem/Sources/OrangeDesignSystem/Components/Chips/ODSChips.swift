//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

/// A thumbnail can be added on the right side of a chip.
/// - Icon is a simple image with only one color
/// - Avatar is the a more complex image like contact photo.
///
public enum ODSChipThumbnail {
    case icon(Image)
    case iconSystem(name: String)
    case avatar(Image)
}

/// <a href="https://system.design.orange.com/0c1af118d/p/85a52b-components/b/1497a4" target="_blank">ODS Chips</a>.
///
/// Chips are small components containing a number of elements that represent a calendar event or contact.
///
public typealias ODSChip<Value> = ODSChipPicker<Value>.ODSChipModel where Value: Hashable

/// Create a picker by providing the selection type with a binding to get selected element(s).
/// An additonnal title can be added above the Picker.
///
public struct ODSChipPicker<Value>: View where Value: Hashable {

    /// The chip element description.
    public struct ODSChipModel {

        let value: Value
        let text: String
        let thumbnail: ODSChipThumbnail?
        let disabled: Bool
        let removable: Bool

        /// Create a chip model that describes the chip contents.
        ///
        /// - Parameters:
        ///     - value: The value of the chip
        ///     - text: Text of the chip
        ///     - thumbnail: Optional leading thumbnail
        ///     - disabled: When disabled, chip will not respond to user input.
        ///     - removable: A cross to the chip and provides a remove action (remove chip from list).
        ///
        public init(_ value: Value, text: String, thumbnail: ODSChipThumbnail? = nil, disabled: Bool = false, removable: Bool = false)
        {
            self.value = value
            self.text = text
            self.thumbnail = thumbnail
            self.disabled = disabled
            self.removable = removable
        }
    }

    /// Creates a picker manages a single selection that allows no element to be selected.
    ///
    /// - Parameters:
    ///     - title: Optional title above the picker
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - chips: All chips describing elements to be displayed.
    ///
    public init(title: String? = nil, selection: Binding<Value?>, chips: [ODSChipModel]) {
        self.title = title
        self.chips = chips

        singleSelectionZero = selection
        singleSelectionOne = nil
        multipleSelection = nil
    }

    /// Creates a picker manages a single selection that avoid to get no element selected (at least one).
    ///
    /// - Parameters:
    ///     - title: Optional title above the picker
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - chips: All chips describing elements to be displayed.
    ///
    public init(title: String? = nil, selection: Binding<Value>, chips: [ODSChipModel]) {
        self.title = title
        self.chips = chips

        singleSelectionZero = nil
        singleSelectionOne = selection
        multipleSelection = nil
    }

    /// Creates a picker manages multiple selections.
    ///
    /// - Parameters:
    ///     - title: Optional title above the picker
    ///     - selection: A binding to a property that determines the
    ///       currently-selected option.
    ///     - allowZeroSelection: If set to true mens that no chip can be selected, otherwise almost one chip is always selected.
    ///     - chips: All chips describing elements to be displayed.
    ///
    public init(title: String? = nil, selection: Binding<[Value]>, allowZeroSelection: Bool = false, chips: [ODSChipModel]) {
        self.title = title
        self.chips = chips

        singleSelectionOne = nil
        singleSelectionZero = nil
        multipleSelection = (selection, allowZeroSelection)
    }

    typealias SingleSelectionZero = Binding<Value?>
    typealias SingleSelectionOne = Binding<Value>
    typealias MultipleSelection = (Binding<[Value]>, Bool)

    let title: String?
    let chips: [ODSChipModel]
    let singleSelectionZero: SingleSelectionZero?
    let singleSelectionOne: SingleSelectionOne?
    let multipleSelection: MultipleSelection?

    @State var textHeight: CGFloat = 30.0

    public var body: some View {
        VStack(alignment: .leading, spacing: ODSSpacing.s) {
            if let title = title {
                Text(title).odsFont(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, ODSSpacing.m)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: ODSSpacing.none) {

                    HStack(spacing: ODSSpacing.s) {
                        ForEach(chips, id: \.value) { chip in
                            Button {
                                handleSelection(for: chip)
                            } label: {
                                HStack(alignment: .center, spacing: ODSSpacing.none) {
                                    if let thumbnail = chip.thumbnail {
                                        ChipThumbnail(selected: isSelected(chip),
                                                      thumbnail: thumbnail,
                                                      height: textHeight)
                                    }

                                    Text(chip.text)
                                        .odsFont(.subhead)
                                        .tint(isSelected(chip) ? .black : .primary)
                                        .padding(.vertical, 6)
                                        .padding(.leading, textLeadingPadding(for: chip))
                                        .padding(.trailing, chip.removable ? ODSSpacing.s : ODSSpacing.m)
                                        .readSize { size in
                                            textHeight = size.height
                                        }

                                    if chip.removable {
                                        ChipRemoveLabel(height: textHeight, selected: isSelected(chip))
                                            .highPriorityGesture(TapGesture().onEnded {})
                                    }
                                }
                            }
                            .background(background(for: chip))
                            .clipShape(Capsule())
                            .disabled(chip.disabled)
                        }
                    }
                    .padding(.trailing, ODSSpacing.s)
                    .padding(.leading, ODSSpacing.m)
                }
            }
        }
    }

    func textLeadingPadding(for chip: ODSChipModel) -> CGFloat {
        switch chip.thumbnail {
        case .icon: return ODSSpacing.s
        case .avatar: return isSelected(chip) ? ODSSpacing.s : ODSSpacing.s - 2
        case .iconSystem: return ODSSpacing.s
        case .none: return ODSSpacing.m
        }
    }

    @ViewBuilder func background(for chip: ODSChipModel) -> some View {
        if isSelected(chip) {
            Capsule().foregroundColor(Color.accentColor)
        } else {
            Capsule().stroke(lineWidth: 1)
        }
    }

    func isSelected(_ chip: ODSChipModel) -> Bool {

        if let singleSelectionZero = singleSelectionZero {
            return chip.value == singleSelectionZero.wrappedValue
        }

        if let singleSelectionOne = singleSelectionOne {
            return chip.value == singleSelectionOne.wrappedValue
        }

        if let multipleSelection = multipleSelection {
            return multipleSelection.0.wrappedValue.contains(where: { chip.value == $0 })
        }

        return false
    }

    func handleSelection(for chip: ODSChipModel) {
        if let singleSelectionZero = singleSelectionZero {
            handle(singleSelectionZero, for: chip)
        } else {
            if let singleSelectionOne = singleSelectionOne {
                handle(singleSelectionOne, for: chip)
            } else {
                if let multipleSelection = multipleSelection {
                    handle(multipleSelection, for: chip)
                }
            }
        }
    }

    func handle(_ singleSelection: SingleSelectionZero, for chip: ODSChipModel) {
        if singleSelection.wrappedValue == chip.value {
            singleSelection.wrappedValue = nil
        } else {
            singleSelection.wrappedValue = chip.value
        }
    }

    func handle(_ singleSelection: SingleSelectionOne, for chip: ODSChipModel) {
        if singleSelection.wrappedValue == chip.value {
        } else {
            singleSelection.wrappedValue = chip.value
        }
    }

    func handle(_ multipleSelection: MultipleSelection, for chip: ODSChipModel) {
        if let index = multipleSelection.0.wrappedValue.firstIndex(where: { $0 == chip.value }) {
            if multipleSelection.0.count != 1 || multipleSelection.1 {
                multipleSelection.0.wrappedValue.remove(at: index)
            }
        } else {
            multipleSelection.0.wrappedValue.append(chip.value)
        }
    }
}

struct ChipThumbnail: View {
    let selected: Bool
    let thumbnail: ODSChipThumbnail
    let height: CGFloat

    var body: some View {
        switch thumbnail {
        case let .avatar(image):
            if selected {
                ChipSelectedAvatar(height: height)
            } else {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: height - 6, height: height - 6, alignment: .center)
                    .clipShape(Circle())
                    .padding(.leading, ODSSpacing.xs)
            }
        case let .icon(image):
            image
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fill)
                .tint(selected ? .black : .primary)
                .frame(width: height - 9, height: height - 9, alignment: .center)
                .padding(.leading, ODSSpacing.s)

        case let .iconSystem(name):
            Image(systemName: name)
                .tint(selected ? .black : .primary)
                .padding(.leading, ODSSpacing.s)
        }
    }
}

struct ChipSelectedAvatar: View {
    let height: CGFloat

    var body: some View {
        Image("iconsFunctionalUiEMIcFormTick", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .tint(Color.accentColor)
            .background(Color.black)
            .frame(width: height - 6, height: height - 6, alignment: .center)
            .clipShape(Circle())
            .padding(.leading, ODSSpacing.xs)
    }
}

struct ChipRemoveLabel: View {

    let height: CGFloat
    let selected: Bool

    var body: some View {
        Image("Close", bundle: Bundle.ods)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .tint(selected ? .black : .primary)
            .frame(width: height - 11, height: height - 11, alignment: .center)
            .padding(.trailing, ODSSpacing.s)
    }
}

#if DEBUG
struct ODSChips_Previews: PreviewProvider {

    enum ChipsTest: Int, CaseIterable {
        case title1 = 1
        case title2
        case removable1
        case removabele2
        case disabled

        var odsChip: ODSChip<ChipsTest> {
            switch self {
            case .title1:
                return ODSChip(self, text: "Title 1")
            case .title2:
                return ODSChip(self, text: "Title 2", thumbnail: .iconSystem(name: "heart"))
            case .removable1:
                return ODSChip(self, text: "Removable 1", removable: true)
            case .removabele2:
                return ODSChip(self, text: "Removable 2", thumbnail: .iconSystem(name: "heart"), removable: true)
            case .disabled:
                return ODSChip(self, text: "Disabled", disabled: true)
            }
        }
    }

    struct ODSChipPickerTest: View {

        @State var selectedOneChip: ChipsTest
        @State var selectedZeroChip: ChipsTest?
        @State var selectedMultipleChipsZero: [ChipsTest] = []
        @State var selectedMultipleChipsOne: [ChipsTest] = []

        let chips: [ODSChip<ChipsTest>]

        init(chipsTest: [ChipsTest], defaultSelectedChip: ChipsTest) {
            chips = chipsTest.map { $0.odsChip }
            selectedOneChip = defaultSelectedChip
            selectedMultipleChipsOne = [defaultSelectedChip]
        }

        var selectedMultipleChipsZeroText: String {
            let text = selectedMultipleChipsZero.reduce(into: "") { result, chip in
                result = "\(result)\(chip.odsChip.text),"
            }

            if text.isEmpty {
                return "No Chip selected"
            }

            return text
        }

        var selectedMultipleChipsOneText: String {
            return selectedMultipleChipsOne.reduce(into: "") { result, chip in
                result = "\(result)\(chip.odsChip.text),"
            }
        }

        var body: some View {
            VStack {
                VStack(spacing: ODSSpacing.s) {
                    VStack(spacing: ODSSpacing.s) {
                        ODSChipPicker(title: "Single selection with zero allowed",
                                      selection: $selectedZeroChip,
                                      chips: chips)
                        Text("Selected Chip : \(selectedZeroChip?.odsChip.text ?? "None")")
                            .padding(.horizontal, ODSSpacing.m)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, ODSSpacing.none)
                    .padding(.bottom, ODSSpacing.l)
                    .background(.green)

                    VStack(spacing: ODSSpacing.s) {
                        ODSChipPicker(title: "Single selection with at least one",
                                      selection: $selectedOneChip,
                                      chips: chips)
                        Text("Selected Chip : \(selectedOneChip.odsChip.text)")
                            .padding(.horizontal, ODSSpacing.m)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, ODSSpacing.none)
                    .padding(.bottom, ODSSpacing.l)
                    .background(.green)

                    VStack(spacing: ODSSpacing.s) {
                        ODSChipPicker(title: "Multiple selection with zero allowed",
                                      selection: $selectedMultipleChipsZero,
                                      allowZeroSelection: true,
                                      chips: chips)

                        Text("Selected Chip : \(self.selectedMultipleChipsZeroText)")
                            .padding(.horizontal, ODSSpacing.m)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, ODSSpacing.none)
                    .padding(.bottom, ODSSpacing.l)
                    .background(.green)

                    VStack(spacing: ODSSpacing.s) {
                        ODSChipPicker(title: "Multiple selection with at least one",
                                      selection: $selectedMultipleChipsOne,
                                      allowZeroSelection: false,
                                      chips: chips)

                        Text("Selected Chip : \(self.selectedMultipleChipsOneText)")
                            .padding(.horizontal, ODSSpacing.m)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, ODSSpacing.none)
                    .padding(.bottom, ODSSpacing.l)
                    .background(.green)
                }
            }
        }
    }

    static var previews: some View {
        ODSChipPickerTest(chipsTest: ChipsTest.allCases,
                          defaultSelectedChip: ChipsTest.title1)
    }
}
#endif
