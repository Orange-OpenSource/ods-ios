/*
 * Software Name: Orange Design System (iOS)
 * SPDX-FileCopyrightText: Copyright (c) 2021-2023 Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license.
 */

import OrangeDesignSystem
import SwiftUI

// =======================
// MARK: - Tab Bar Variant
// =======================

struct TabBarVariant: View {

    // ================
    // MARK: Properties
    // ================

    @ObservedObject var model: TabBarVariantModel
    @State var spacerHeight: CGFloat
    
    // =================
    // MARK: Initializer
    // =================
    
    init(model: TabBarVariantModel) {
        self.model = model
        spacerHeight = Self.computeSpacerHeight()
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

// ======================
// MARK: - Badge Modifier
// ======================

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
                Stepper("screens.guidelines.bars.tabs.items_stepper.hint".localized(with: ["\(model.itemsCount)"]),
                        value: $model.itemsCount,
                        in: 2 ... model.numberOfItems)
            }
            .padding(.horizontal, ODSSpacing.m)
            .odsFont(.bodyBold)
            
            ODSChipPicker(title: "screens.guidelines.bars.tabs.options_picker.hint".🌐,
                          selection: $model.badgeOption,
                          chips: TabBarVariantModel.BadgeOption.chips)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
    }
}

// =============================
// MARK: - Tab Bar Variant Model
// =============================

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
            ItemDescription(iconName: "Heart_19371",
                            text: "screens.guidelines.bars.tabs.item_favorite.title".🌐,
                            contentText: "screens.guidelines.bars.tabs.item_favorite.description".🌐,
                            badgeOption: badgeOption),
            ItemDescription(iconName: "Search_19371",
                            text: "screens.guidelines.bars.tabs.item_search.title".🌐,
                            contentText: "screens.guidelines.bars.tabs.item_search.description".🌐,
                            badgeOption: .none),
            ItemDescription(iconName: "Info_19371",
                            text: "screens.guidelines.bars.tabs.item_information.title".🌐,
                            contentText: "screens.guidelines.bars.tabs.item_information.description".🌐,
                            badgeOption: .none),
            ItemDescription(iconName: "Notification_Alert_19371",
                            text: "screens.guidelines.bars.tabs.item_notification.title".🌐,
                            contentText: "screens.guidelines.bars.tabs.item_notification.description".🌐,
                            badgeOption: .none),
            ItemDescription(iconName: "Settings_19371",
                            text: "screens.guidelines.bars.tabs.item_settings.title".🌐,
                            contentText: "screens.guidelines.bars.tabs.item_settings.description".🌐,
                            badgeOption: .none),
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
                return "screens.guidelines.bars.tabs.badge.description.none".🌐
            case .count:
                return "screens.guidelines.bars.tabs.badge.description.count".🌐
            case .text:
                return "screens.guidelines.bars.tabs.badge.description.text".🌐
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
