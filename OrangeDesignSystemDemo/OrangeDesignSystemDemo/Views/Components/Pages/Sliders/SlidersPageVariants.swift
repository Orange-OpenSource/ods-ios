//
//  SlidersPageVariants.swift
//  OrangeDesignSystemDemo
//
//  Created by Jean-Luc CHEVALIER on 25/11/2022.
//

import OrangeDesignSystem
import SwiftUI

class SliderVariantModel: ObservableObject {

    @Published var showValue: Bool
    @Published var steppedValue: Bool

    init() {
        showValue = true
        steppedValue = true
    }
}


struct SliderVariant: View {
    @ObservedObject var model: SliderVariantModel

    var body: some View {
        ZStack {
            ScrollView {
                LabeledSlider()
                .padding(.horizontal, ODSSpacing.s)
                .padding(.top, ODSSpacing.m)
            }

            BottomSheet(showContent: false) {
                SliderBottomSheetContent()
            }
            .environmentObject(model)
        }
    }
}

struct SliderBottomSheetContent: View {

    @EnvironmentObject var model: SliderVariantModel

    var body: some View {
        VStack(spacing: ODSSpacing.m) {
            Toggle("Labeled", isOn: $model.showValue)
            Toggle("Stepped", isOn: $model.steppedValue)
        }
        .odsFont(.bodyRegular)
        .padding(.vertical, ODSSpacing.m)
        .padding(.horizontal, ODSSpacing.m)
    }
}
