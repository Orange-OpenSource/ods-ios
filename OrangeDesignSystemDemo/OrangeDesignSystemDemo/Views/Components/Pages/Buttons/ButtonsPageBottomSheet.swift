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

// MARK: Bottom sheet for Emphasis and Functionnal

class ButtonContentModel: ObservableObject {
    @Published var showIcon: Bool
    @Published var showVariableWidth: Bool
    @Published var showLongText: Bool
    @Published var showDisabled: Bool

    init() {
        showIcon = false
        showVariableWidth = false
        showLongText = false
        showDisabled = false
    }

    var text: LocalizedStringKey {
        showLongText ? "Terms and conditions" : (showDisabled ? "Disabled" : "Enabled")
    }

    var icon: Image? {
        showIcon ? Image("Add") : nil
    }
}

struct ButtonsBottomSheetContent: View {

    @EnvironmentObject var model: ButtonContentModel

    var body: some View {
        VStack {
            Toggle("Show icon", isOn: $model.showIcon)
            Toggle("Show variable width", isOn: $model.showVariableWidth)
            Toggle("Show disabled", isOn: $model.showDisabled)
            Toggle("Show long text", isOn: $model.showLongText)
        }
        .padding(.horizontal, ODSSpacing.m)
        .padding(.vertical, ODSSpacing.s)
    }
}

// MARK: Bottom sheet for IconButton

class IconButtonModel: ObservableObject {
    @Published var showDisabled: Bool

    init() {
        showDisabled = false
    }
}
