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

import SwiftUI
import OrangeDesignSystem

struct EmptyStateModuleDemo: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @ObservedObject var model: EmptyStateModuleModel
    @State private var showAlert: Bool = false
    @State private var alertText: String = ""
    
    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack {
            if let image = image {
                ODSEmptyStateView(
                    title: model.usageOption.title,
                    text: text,
                    image: image,
                    button: button
                )
            } else {
                ODSEmptyStateView(
                    title: model.usageOption.title,
                    text: text,
                    button: button
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(model.usageOption.title)
        .alert(alertText, isPresented: $showAlert) {
            Button("shared.close", role: .cancel) {}
        }
    }

    // =====================
    // MARK: private helpers
    // =====================

    @ViewBuilder
    private var text: Text? {
        if model.showSubtitle {
            model.usageOption.text
        }
    }

    @ViewBuilder
    private var image: Image? {
        if let imageName = model.usageOption.imageName {
            ThemeProvider().imageFromResources(imageName)
        }
    }

    @ViewBuilder
    private var button: Button<Text>? {
        if model.showButton {
            Button {
                alertText = "screens.modules.empty_state.usage.alert" <- "\(model.usageOption.buttonLabel)"
                showAlert = true
            } label: {
                Text(model.usageOption.buttonLabel)
            }
        }
    }
}


#if DEBUG
struct EmptyStateModuleDemo_Previews: PreviewProvider {

    static var previews: some View {
        EmptyStateModuleSetup(model: EmptyStateModuleModel())
    }
}
#endif
