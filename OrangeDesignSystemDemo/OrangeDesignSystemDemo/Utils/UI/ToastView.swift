//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import OrangeDesignSystem
import SwiftUI

struct Toastable<Content>: View where Content: View {

    // =======================
    // MARK: Stored Properties
    // =======================
    @Binding var showText: String?
    private let content: () -> Content

    // ==========
    // MARK: Body
    // ==========
    var body: some View {
        ZStack {
            content()
            Toast(showText: $showText)
        }
    }
}

struct Toast: View {

    // =======================
    // MARK: Stored Properties
    // =======================
    @Binding var showText: String?

    // ==========
    // MARK: Body
    // ==========
    var body: some View {
        if let showText = self.showText {
            Text(showText)
                .padding().background(Color(UIColor.systemGray4)).clipShape(Capsule())
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showText = nil
                    }
                }
        }
    }
}
