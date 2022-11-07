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

struct ButtonComponent: Component {
    let title: String
    let image: Image
    let description: String
    let variants: AnyView
    
    init() {
        title = "Buttons"
        image = Image("Buttons - Shape")
        description = "A button allows a user to perform an action or to navigate to another page. It contains a text label and a supporting icon can be displayed."
        variants = AnyView(ButtonVariants())
    }
}

struct ButtonVariants: View {

    var body: some View {
        NavigationLink {
            CommonButtonVariant(model: ButtonContentModel()) { model in
                EmphasisVariants(model: model)
            }
            .navigationTitle("Emphasis")
        } label: {
            Item(text: "Emphasis", objectName: "ODSButton")
        }
        
        NavigationLink {
            CommonButtonVariant(model: ButtonContentModel()) { model in
                FunctionalVariants(model: model)
            }
            .navigationTitle("Functional")
        } label: {
            Item(text: "Functional", objectName: "ODSFunctionalButton")
        }
        
        NavigationLink {
            IconVariant(model: IconButtonModel())
                .navigationTitle("Icon")
        } label: {
            Item(text: "Icons", objectName: "ODSIconButton")
        }
    }

    @ViewBuilder func Item(text: String, objectName: String) -> some View {
        VStack(alignment: .leading) {
            Text(text)
                .odsFont(.bodyRegular)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text(objectName)
                .font(.system(.caption, design: .monospaced))
                .padding(.bottom, ODSSpacing.none)
        }
        .accessibilityElement()
        .accessibilityLabel("\(text), Techinal element: \(objectName)")
    }
}

struct CommonButtonVariant<Variant>: View where Variant: View {
    let model: ButtonContentModel

    let contentView: (_ model: ButtonContentModel) -> Variant

    init(model: ButtonContentModel, @ViewBuilder contentView: @escaping (_ model: ButtonContentModel) -> Variant) {
        self.model = model
        self.contentView = contentView
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: ODSSpacing.m) {
                    contentView(model)
                }
                .padding(.top, ODSSpacing.m)
                .padding(.horizontal, ODSSpacing.m)
            }
            .padding(.bottom, 55)

            BottomSheet(showContent: false) {
                ButtonsBottomSheetContent()
            }
            .environmentObject(model)
        }
        .background(Color("componentBackground2"))
    }
}
