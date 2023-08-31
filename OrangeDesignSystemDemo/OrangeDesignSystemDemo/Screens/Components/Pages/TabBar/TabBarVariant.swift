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

struct TabBarVariant: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: TabBarVariantModel
    @State var spacerHeight: CGFloat
    
    // =================
    // MARK: Initializer
    // =================
    init(model: TabBarVariantModel) {
        self.model = model
        self.spacerHeight = Self.computeSpacerHeight()
        
    }
    
    private static func computeSpacerHeight() -> CGFloat {
        return UIDevice.current.orientation.isLandscape ? 100.0 : 350.0
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        CustomizableVariant {
            GeometryReader { reader in
                VStack(alignment: .center, spacing: 0) {
                    VStack {
                        TabView {
                            ForEach(model.availableItems, id: \.text) { itemDescription in
                                tabBarItem(from: itemDescription)
                                    .modifier(BadgeModifier(badgeOption: itemDescription.badgeOption))
                            }
                        }
                    }
                    .border(.gray)
                    
                    Spacer().frame(height: spacerHeight)
                }
                .padding(.horizontal, ODSSpacing.m)
                .padding(.top, ODSSpacing.s)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                spacerHeight = Self.computeSpacerHeight()
            }
        } options: {
            TabBarVariantOptions(model: model)
        }
    }

    // =============
    // MARK: Helpers
    // =============
    
    private func tabBarItem(from itemDescription: TabBarVariantModel.ItemDescription) -> some View {
        Text(itemDescription.contentText)
            .tabItem {
                Label(itemDescription.text, image: itemDescription.iconName)
            }
    }
}

private struct BadgeModifier: ViewModifier {
    
    // ======================
    // MARK: Store properties
    // ======================

    let badgeOption: TabBarVariantModel.BadgeOption

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        if badgeOption == .none {
            content
        }
        if badgeOption == .text {
            content.badge("!")
        }
        if badgeOption == .count {
            content.badge(10)
        }
    }
}

struct TabBarVariantOptions: View {

    // ======================
    // MARK: Store properties
    // ======================

    @ObservedObject var model: TabBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Group {
                Stepper("Number of items: \(model.itemsCount)",
                        value: $model.itemsCount,
                        in: 2 ... model.numberOfItems)
            }
            .padding(.horizontal, ODSSpacing.m)
            .odsFont(.bodyBold)
            
            ODSChipPicker(title: "Badge options",
                          selection: $model.badgeOption,
                          chips: TabBarVariantModel.BadgeOption.chips)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}

class TabBarVariantModel: ObservableObject {
    
    // ======================
    // MARK: Store properties
    // ======================

    @Published var itemsCount: Int
    @Published var badgeOption: BadgeOption {
        didSet {
            updateItems()
        }
    }
    
    var itemDescriptions: [ItemDescription]

    // =================
    // MARK: Initializer
    // =================

    init() {
        itemsCount = 2
        badgeOption = .none
        itemDescriptions = []
        updateItems()
    }
    
    // =============
    // MARK: Helpers
    // =============
    private func updateItems() {
        itemDescriptions = [
            // Display the badge only on the first item
            ItemDescription(iconName: "Heart_19371", text: "Favorites", contentText: "Favorites Content view", badgeOption: badgeOption),
            ItemDescription(iconName: "Search_19371", text: "Search", contentText: "Search Content view", badgeOption: .none),
            ItemDescription(iconName: "Info_19371", text: "Information", contentText: "Information Content view", badgeOption: .none),
            ItemDescription(iconName: "Notification_Alert_19371", text: "Notification", contentText: "Notification Content view", badgeOption: .none),
            ItemDescription(iconName: "Settings_19371", text: "Settings", contentText: "Settings Content view", badgeOption: .none),
        ]
    }
    
    var availableItems: [ItemDescription] {
        Array(itemDescriptions.prefix(itemsCount))
    }
    
    var numberOfItems: Int {
        itemDescriptions.count
    }
    
    struct ItemDescription {
        let iconName: String
        let text: String
        let contentText: String
        let badgeOption: BadgeOption
    }
    
    enum BadgeOption: Int, CaseIterable {
        case none = 0
        case count
        case text
        
        var description: String {
            switch self {
            case .none:
                return "None"
            case .count:
                return "Count"
            case .text:
                return "Text"
            }
        }
        
        var chip: ODSChip<Self> {
            ODSChip(self, text: self.description)
        }
        
        static var chips: [ODSChip<Self>] {
            Self.allCases.map { $0.chip }
        }
    }
}
