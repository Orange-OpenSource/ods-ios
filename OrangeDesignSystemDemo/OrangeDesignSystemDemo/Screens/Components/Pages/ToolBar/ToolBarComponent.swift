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

// ==========================
// MARK: - Tool Bar Component
// ==========================

struct ToolBarComponent: Component {
    let name: String
    let imageName: String
    let description: String
    let variants: AnyView

    init() {
        name = °°"screens.components.bars.tools.title"
        imageName = "Bars - tool"
        description = °°"screens.components.bars.tools.description"
        variants = AnyView(ToolBarVariants())
    }
}

// =========================
// MARK: - Tool Bar Variants
// =========================

private struct ToolBarVariants: View {

    var body: some View {
        VariantEntryItem(title: "screens.components.bars.tools.title", technicalElement: "odsToolBar()") {
            ToolBarVariantHome(model: ToolBarVariantModel())
                .odsNavigationTitle("screens.components.bars.tools.title".🌐)
        }
    }
}

// ==============================
// MARK: - Tool Bar Variants Home
// ==============================

private struct ToolBarVariantHome: View {

    // ================
    // MARK: Properties
    // ================

    @ObservedObject private var model: ToolBarVariantModel
    @State private var showToolBar = false

    // =================
    // MARK: Initializer
    // =================

    init(model: ToolBarVariantModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        ScrollView {
            VStack {
                Text("screens.components.bars.tools.hint")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ODSSpacing.m)

                ToolBarVariantOptions(model: model)
                    .padding(.top, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.xl)

                ODSButton(text: Text("screens.components.bars.tools.open.hint"), emphasis: .high, fullWidth: true) {
                    showToolBar = true
                }
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.top, ODSSpacing.m)
        }
        .sheet(isPresented: $showToolBar) {
            ToolBarVariantContent(model: model)
        }
    }
}

// =================================
// MARK: - Tool Bar Variants Content
// =================================

private struct ToolBarVariantContent: View {

    // ================
    // MARK: Properties
    // ================

    @ObservedObject private var model: ToolBarVariantModel
    @Environment(\.dismiss) private var dismiss

    // =================
    // MARK: Initializer
    // =================

    init(model: ToolBarVariantModel) {
        self.model = model
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        NavigationView {
            VStack(spacing: ODSSpacing.m) {

                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 55, height: 4, alignment: .center)
                    .padding(.top, ODSSpacing.s)
                    .padding(.bottom, ODSSpacing.xs)

                Spacer()

                ODSButton(text: Text("screens.components.bars.tools.close.hint"), emphasis: .high, fullWidth: true) {
                    dismiss()
                }

                Spacer()

                switch model.itemType {
                case .label:
                    Text("screens.components.bars.tools.with_labels.title")
                case .icon:
                    Text("screens.components.bars.tools.with_icons.title")
                }
            }
            .padding(.horizontal, ODSSpacing.m)
            .padding(.bottom, ODSSpacing.m)
            .navigationBarHidden(true)
            .modifier(ToolBarVariantContentModifier(model: model))
        }
        .alert(model.alertText, isPresented: $model.showAlert) {
            Button("shared.close", role: .cancel) {}
        }
    }
}

// ==========================================
// MARK: - Tool Bar Variants Content Modifier
// ==========================================

private struct ToolBarVariantContentModifier: ViewModifier {

    // ================
    // MARK: Properties
    // ================

    @ObservedObject var model: ToolBarVariantModel

    // ==========
    // MARK: Body
    // ==========

    func body(content: Content) -> some View {
        switch model.itemType {
        case .label:
            content.odsToolBar(items: model.labelItems)
        case .icon:
            content.odsToolBar(items: model.iconItems)
        }
    }
}

#if DEBUG
struct ToolBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        ThemeablePreviews {
            NavigationView {
                List {
                    ToolBarVariants()
                }
            }
        }
    }
}
#endif
