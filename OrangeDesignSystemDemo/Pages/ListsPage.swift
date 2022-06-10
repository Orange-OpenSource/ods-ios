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

import OrangeDesignSystem
import SwiftUI

class ListsPageModel: ObservableObject {

    @Published var showSubtitle: Bool
    @Published var showLeftIcon: Bool
    @Published var showRightIcon: Bool
    @Published var minHeight: ODSListItemMinHeight

    @State var toggleAcivated: Bool

    var rightIcons: [ODSListItemRightIconModel]

    init(showSubtitle: Bool = false,
         showLeftIcon: Bool = false,
         showRightIcon: Bool = true)
    {
        self.showSubtitle = showSubtitle
        self.showLeftIcon = showLeftIcon
        self.showRightIcon = showRightIcon
        minHeight = .medium

        toggleAcivated = false
        rightIcons = [.chevron(nil)]
        rightIcons.append(.chevron("Details"))
        rightIcons.append(.text("Details"))
        rightIcons.append(.toggle($toggleAcivated))
    }

    var odsListItemModels: ODSListModel {

        let items: [ODSListItemModel] = rightIcons.map { icon in
            let title = "Title"
            let subTitle = showSubtitle ? "The subtitle" : nil
            let image = Image("logo2OrangeSmallLogo", bundle: Bundle.bundle)
            let leftIconModel = showLeftIcon ? ODSListItemLeftIconModel.withImage(image) : nil
            let rightIconModel = showRightIcon ? icon : nil

            return ODSListItemModel(title: title,
                                    subtitle: subTitle,
                                    leftIconModel: leftIconModel,
                                    rightIconModel: rightIconModel,
                                    minHeight: minHeight)
        }

        return ODSListModel(itemModels: items + items + items + items)
    }
}

struct ListsPage: View {

    @ObservedObject var listsPageModel: ListsPageModel

    init() {
        listsPageModel = ListsPageModel()
    }

    var body: some View {
        ZStack {
            ODSList(model: listsPageModel.odsListItemModels)

            BottomSheet()
                .environmentObject(listsPageModel)
        }
    }
}

// ===================
// MARK: Bottom sheet
// ===================

struct BottomSheet: View {
    @State var showContent: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: 0) {
                BottomSheedHeader(showContent: $showContent)
                    .background(Color(UIColor.systemGray6))

                if showContent {
                    BottomSheetContent()
                }
            }
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct BottomSheedHeader: View {

    @Binding var showContent: Bool

    var body: some View {
        VStack {
            Button {
                showContent.toggle()
            } label: {
                VStack(spacing: 0) {
                    Divider()

                    HStack(spacing: 16) {
                        let imageName = showContent ? "chevron.down" : "chevron.up"

                        Image(systemName: imageName)
                            .foregroundColor(.primary)
                            .accessibility(hidden: true)

                        Text("Swipe down to view")
                            .font(.body)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.all, 8)

                    Divider()
                }
            }
        }
    }
}

struct BottomSheetContent: View {

    @EnvironmentObject var listPageModel: ListsPageModel

    var body: some View {
        VStack(spacing: 8) {
            Toggle("Show left icon", isOn: $listPageModel.showLeftIcon)
            Divider()
            Toggle("Show subtitle", isOn: $listPageModel.showSubtitle)
            Divider()
            BottomSheetListItemHeight(minHeight: $listPageModel.minHeight)
//            Toggle("Show as large", isOn: $listPageModel.minHeight)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

class ListHeitghtChip: ODSGenericChip {

    var height: ODSListItemMinHeight

    init(heightDescription: String, height: ODSListItemMinHeight, isSelected: Bool = false) {
        self.height = height
        super.init(name: heightDescription, isSelected: isSelected)
    }
}

struct BottomSheetListItemHeight: View {
    var chips: [ListHeitghtChip]
    var lastSelectedHeight: Binding<ODSListItemMinHeight>

    var body: some View {
        VStack {
            Text("List item min height").frame(maxWidth: .infinity, alignment: .leading)

            ODSChipsView(chips: chips, selectionType: .single) { chip in
                self.lastSelectedHeight.wrappedValue = chip.height
            }
        }
    }

    init(minHeight: Binding<ODSListItemMinHeight>) {
        chips = [
            ListHeitghtChip(heightDescription: "Large", height: .large, isSelected: minHeight.wrappedValue == .large),
            ListHeitghtChip(heightDescription: "Medium", height: .medium,
                            isSelected: minHeight.wrappedValue == .medium),
        ]

        lastSelectedHeight = minHeight
    }
}

struct List_Previews: PreviewProvider {

    struct ChipSelectionTest: View {
        let chips = [
            ODSGenericChip(name: "Chip 1", isSelected: false),
            ODSGenericChip(name: "Chip 2", isSelected: false),
            ODSGenericChip(name: "Chip 3", isSelected: false),
            ODSGenericChip(name: "Chip 4", isSelected: false),
        ]

        @State var lastSelectedChipMessage: String = ""

        var body: some View {
            VStack {
                ODSChipsView(chips: chips, selectionType: .multiple) { chip in
                    lastSelectedChipMessage = "\(chip.name) is \(chip.isSelected ? "Selected" : "Unselected")"
                }

                Text(lastSelectedChipMessage)
            }
        }
    }

    static var previews: some View {
        ChipSelectionTest()
//        ListsPage()
    }
}

// ===========
// MARK: Chips
// ===========
public enum ODSChipsSelectionType {
    case multiple
    case single
}

public protocol ODSChipProtocol: Identifiable where Self: AnyObject {
    var id: String { get set }
    var name: String { get set }
    var isSelected: Bool { get set }
}

public class ODSGenericChip: ODSChipProtocol {
    public var id: String
    public var name: String
    public var isSelected: Bool

    public init(name: String, isSelected: Bool = false) {
        id = UUID().uuidString
        self.name = name
        self.isSelected = isSelected
    }
}

public struct ODSChipsView<T: ODSChipProtocol>: View {
    private let chips: [T]
    private var selectionType: ODSChipsSelectionType
    private let onChipTapped: (T) -> Void

    public init(chips: [T], selectionType: ODSChipsSelectionType, onChipTapped: @escaping (T) -> Void) {
        self.chips = chips
        self.selectionType = selectionType
        self.onChipTapped = onChipTapped
    }

    public var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(chips, id: \.id) { chip in
                    ODSChipView(
                        chip: chip,
                        isSelected: chip.isSelected) { chip in
                            select(chip)
                            onChipTapped(chip)
                        }
                }
            }
            .padding(.horizontal, 8)
            .padding(.leading, 5)
            .padding(.trailing, 10)
        }
    }

    private func select(_ chip: T) {
        switch selectionType {
        case .multiple:
            break
        case .single:
            for chip in chips {
                chip.isSelected = false
            }
        }

        chip.isSelected.toggle()
    }
}

struct ODSChipView<T: ODSChipProtocol>: View {
    let chip: T
    let isSelected: Bool
    let onChipSelected: (T) -> Void

    init(chip: T,
         isSelected: Bool,
         onChipSelected: @escaping (T) -> Void)
    {
        self.chip = chip
        self.isSelected = isSelected
        self.onChipSelected = onChipSelected
    }

    var body: some View {
        VStack {
            Button {
                onChipSelected(chip)
            } label: {
                ODSGenericButtonContent(bottomText: chip.name, textColor:
                    isSelected ? ODSColor.coreOrange.color : .primary)
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Capsule().stroke(Color.black, lineWidth: 2))
                    .clipShape(Capsule())
            }
        }
    }
}
