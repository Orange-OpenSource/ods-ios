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

import SwiftUI
import OrangeDesignSystem

// MARK: Button sheet with header and content
struct BottomSheet<ContentView>: View where ContentView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State var showContent: Bool = false
    let contentView: ContentView

    // =================
    // MARK: Initializer
    // =================

    init(@ViewBuilder contentView: @escaping () -> ContentView) {
        self.contentView = contentView()
    }

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            Spacer()
            
            VStack(spacing: ODSSpacing.none) {
                BottomSheedHeader(showContent: showContent)
                    .onTapGesture {
                        withAnimation(Animation.linear) {
                            showContent.toggle()
                        }
                    }

                if showContent {
                    contentView
                        .background(Color(UIColor.systemBackground))
                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom)))
                }
            }
        }
        .task {
            withAnimation(Animation.linear.delay(0.5)) {
                self.showContent = true
            }
        }
    }
}

private struct BottomSheedHeader: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    let showContent: Bool

    // ==========
    // MARK: Body
    // ==========

    var body: some View {
        VStack(spacing: ODSSpacing.none) {
            RoundedRectangle(cornerRadius: 4)
                .frame(width: 55, height: 4, alignment: .center)
                .padding(.top, ODSSpacing.s)
                .padding(.bottom, ODSSpacing.xs)

            VStack(spacing: ODSSpacing.none) {
                HStack(spacing: ODSSpacing.m) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.primary)
                        .rotationEffect(.degrees(showContent ? 0 : -180))
                        .accessibility(hidden: true)
                    
                    Text("Customize")
                        .odsFont(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.all, ODSSpacing.s)
                
                Divider()
            }
        }
        .background(Color(.systemGray6))
        .padding(.bottom, 10)
        .cornerRadius(10)
        .padding(.bottom, -10)
        .shadow(color: Color(UIColor.systemGray), radius: 8)
        .mask(Rectangle().padding(.top, -20))
    }
}
