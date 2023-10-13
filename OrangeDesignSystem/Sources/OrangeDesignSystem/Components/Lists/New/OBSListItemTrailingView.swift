////
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

import SwiftUI

public struct ODSListItemTrailing: View {

    enum MyType {
        case textOnly(Text)
        case iButton(() -> Void)
        case iButtonAndText(() -> Void, Text)
        case toggle(Binding<Bool>)
        case checkmark(Bool)
    }

    // =======================
    // MARK: Stored Properties
    // =======================

    @Environment(\.theme) private var theme
    let mytype: ODSListItemTrailing.MyType

    // ==================
    // MARK: Initializers
    // ==================

    public init(text: Text) {
        self.mytype = .textOnly(text)
    }

    public init(action: @escaping () -> Void) {
        self.mytype = .iButton(action)
    }

    public init(text: Text, action: @escaping () -> Void) {
        self.mytype = .iButtonAndText(action, text)
    }

    public init(toogleIsOn: Binding<Bool>) {
        self.mytype = .toggle(toogleIsOn)
    }
    public init(checkmarkIsVisible: Bool) {
        self.mytype = .checkmark(checkmarkIsVisible)
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        switch mytype {
        case .textOnly(let text):
            text

        case .iButton(let action):
            ODSIconButton(image: Image(systemName: "info.circle"), action: action)
                .buttonStyle(PlainButtonStyle())

        case .iButtonAndText(let action, let text):
            HStack {
                text
                ODSIconButton(image: Image(systemName: "info.circle"), action: action)
                    .buttonStyle(PlainButtonStyle())
            }

        case .toggle(let isOn):
            Toggle(isOn: isOn) {
                EmptyView()
            }

        case .checkmark(let isVisible):
            if isVisible {
                Image(systemName: "checkmark")
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .font(.body.bold())
                    .foregroundColor(theme.componentColors.accent)
                    .frame(height: 44)
            } else {
                EmptyView()
            }
        }
    }
}
