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
    let imageName: String
    let description: String
    let variants: AnyView
    
    init() {
        title = "Buttons"
        imageName = "Buttons - Shape"
        description = "A custom button allows a user to perform an important call to action. This button that contains a text"
        variants = AnyView(ButtonVariants())
    }
}


struct ButtonVariants: View {

    var body: some View {
        VariantEntryItem(text: "Emphasis", technicalElement: "ODSButton()") {
            CommonButtonVariant(model: EmphasisAndFunctionnalVariantModel()) { model in
                EmphasisVariant(model: model)
            }
            .navigationTitle("Emphasis")
        }
        
        VariantEntryItem(text: "Functional", technicalElement: "ODSFunctionalButton()") {
            
            CommonButtonVariant(model: EmphasisAndFunctionnalVariantModel()) { model in
                FunctionalVariant(model: model)
            }
            .navigationTitle("Functional")
        }
        
        VariantEntryItem(text: "Icons", technicalElement: "ODSIconButton()") {
            IconVariant(model: IconVariantModel())
                .navigationTitle("Icon")
        }
    }
}

struct CommonButtonVariant<Variant>: View where Variant: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let model: EmphasisAndFunctionnalVariantModel
    let contentView: (_ model: EmphasisAndFunctionnalVariantModel) -> Variant

    // =================
    // MARK: Initializer
    // =================

    init(model: EmphasisAndFunctionnalVariantModel, @ViewBuilder contentView: @escaping (_ model: EmphasisAndFunctionnalVariantModel) -> Variant) {
        self.model = model
        self.contentView = contentView
    }

    // ==========
    // MARK: Body
    // ==========

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

            BottomSheet {
                EmphasisAndFunctionalVariantOptions(model: model)
            }
        }
        .background(Color("componentBackground2"))
    }
}
