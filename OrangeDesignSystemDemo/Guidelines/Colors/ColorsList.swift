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

import Foundation
import OrangeDesignSystem
import SwiftUI

class ScreenState: ObservableObject {
    @Published var colorScheme: ColorScheme = .light
}

struct ColorList: View {

    // MARK: - Dark/Light managment
    @Environment(\.colorScheme) var phoneColorScheme: ColorScheme
    @EnvironmentObject var screenState: ScreenState

    // MARK: - Body
    var body: some View {

        VStack {
            Spacer().frame(height: 10)
            Text("Palette")
                .odsFont(style: .title1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))

            Picker("Favorite Scheme", selection: $screenState.colorScheme, content: {
                Text("On Light").tag(ColorScheme.light)
                Text("On Dark").tag(ColorScheme.dark)
            }).pickerStyle(.segmented)
                .onAppear {
                    screenState.colorScheme = phoneColorScheme
                }.padding(EdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15))

            ScrollView {
                Spacer().frame(height: 5)
                SectionTitle(title: "Core")
                VStack {
                    Spacer().frame(height: 30)
                    HStack(spacing: 15) {
                        colorBigView(color: ODSColor.coreOrange, bordered: false)
                        colorBigView(color: ODSColor.coreWhite, bordered: screenState.colorScheme == .light)
                    }
                    HStack(spacing: 15) {
                        colorBigView(color: ODSColor.coreBlack, bordered: screenState.colorScheme == .dark)
                        colorBigView(color: ODSColor.coreObsGrey, bordered: false)
                    }
                }
                Spacer().frame(height: 30)
                SectionTitle(title: "Functional")
                VStack {
                    HStack(spacing: 15) {
                        colorBigView(color: ODSColor.functionalPositive, bordered: false)
                        colorBigView(color: ODSColor.functionalNegative, bordered: false)
                    }
                    HStack(spacing: 15) {
                        colorBigView(color: ODSColor.functionalAlert, bordered: false)
                        colorBigView(color: ODSColor.functionalInfo, bordered: false)
                    }
                }
                Spacer().frame(height: 30)
                SectionTitle(title: "Supporting")
                VStack {
                    HStack(spacing: 15) {
                        colorSmallView(color: ODSColor.supportingBlue100)
                        colorSmallView(color: ODSColor.supportingBlue200)
                        colorSmallView(color: ODSColor.supportingBlue300)
                    }
                    HStack(spacing: 15) {
                        colorSmallView(color: ODSColor.supportingYellow100)
                        colorSmallView(color: ODSColor.supportingYellow200)
                        colorSmallView(color: ODSColor.supportingYellow300)
                    }
                    HStack(spacing: 15) {
                        colorSmallView(color: ODSColor.supportingGreen100)
                        colorSmallView(color: ODSColor.supportingGreen200)
                        colorSmallView(color: ODSColor.supportingGreen300)
                    }
                    HStack(spacing: 15) {
                        colorSmallView(color: ODSColor.supportingPink100)
                        colorSmallView(color: ODSColor.supportingPink200)
                        colorSmallView(color: ODSColor.supportingPink300)
                    }
                    HStack(spacing: 15) {
                        colorSmallView(color: ODSColor.supportingPurple100)
                        colorSmallView(color: ODSColor.supportingPurple200)
                        colorSmallView(color: ODSColor.supportingPurple300)
                    }
                }
            }.padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
                .background(screenState.colorScheme == .light ? Color.white : Color.black)
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: ColorUsage()) {
                    Text("Usage")
                }.foregroundColor(ODS.coreOrange)
            }
        }
    }
}

struct SectionTitle: View {
    var title: String
    @EnvironmentObject var screenState: ScreenState

    var body: some View {
        Text(title).odsFont(style: .title1)
            .foregroundColor(screenState.colorScheme == .dark ? Color.white : Color.black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct colorBigView: View {

    let color: ODSColor
    @EnvironmentObject var screenState: ScreenState
    @State private var showingModal = false

    var bordered: Bool

    var body: some View {

        let tap = TapGesture().onEnded { _ in showingModal.toggle() }

        VStack(alignment: .leading) {
            if bordered {
                Rectangle()
                    .fill(color.color)
                    .border(Color.secondary)
                    .aspectRatio(1.0, contentMode: .fit)
            } else {
                Rectangle()
                    .fill(color.color)
                    .aspectRatio(1.0, contentMode: .fit)
            }
            Text(color.displayName(forScheme: screenState.colorScheme)).odsFont(style: .headline)
            Text(color.rawValue).font(.system(.caption, design: .monospaced))
            Text(color.rgb(forScheme: screenState.colorScheme).toString()).odsFont(style: .caption1Regular)
            Text(color.hexa(forScheme: screenState.colorScheme)).odsFont(style: .caption1Regular)
        }.background(Color(uiColor: UIColor.systemBackground))
            .colorScheme(screenState.colorScheme)
            .gesture(tap)
            .fullScreenCover(isPresented: $showingModal) { ColorDetailView(color: self.color) }
    }
}

struct ColorDetailView: View {

    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var phoneColorScheme: ColorScheme
    @EnvironmentObject var screenState: ScreenState

    let color: ODSColor

    var body: some View {
        ZStack {

            BackgroundBlurView().edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {
                Rectangle().fill(color.color)
                    .frame(width: 300, height: 150)

                VStack(alignment: .leading, spacing: 3) {
                    Text(color.displayName(forScheme: self.screenState.colorScheme)).odsFont(style: .headline)
                    Text(color.rawValue).font(.system(.caption, design: .monospaced))
                    Text(color.rgb(forScheme: screenState.colorScheme).toString()).odsFont(style: .caption1Regular)
                    Text(color.hexa(forScheme: screenState.colorScheme)).odsFont(style: .caption1Regular)

                    Spacer().frame(height: 15)

                    Text("Usage").odsFont(style: .headline)
                    Text("Coming soon ...").odsFont(style: .caption1Regular)

                }.padding(EdgeInsets(top: 10, leading: 15, bottom: 20, trailing: 15))
            }.background(Color(uiColor: UIColor.systemGray6))
                .cornerRadius(10)
        }.onTapGesture {
            dismiss()
        }
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct colorSmallView: View {

    let color: ODSColor
    @EnvironmentObject var screenState: ScreenState
    @State private var showingModal = false

    var body: some View {

        let tap = TapGesture().onEnded { _ in showingModal.toggle() }

        VStack(alignment: .leading) {
            Rectangle()
                .fill(color.color)
                .aspectRatio(1.0, contentMode: .fit)
            Text(color.displayName(forScheme: screenState.colorScheme)).odsFont(style: .headline)
            Text(color.hexa(forScheme: screenState.colorScheme)).odsFont(style: .caption1Regular)
        }.background(Color(uiColor: UIColor.systemBackground))
            .colorScheme(self.screenState.colorScheme)
            .gesture(tap)
            .fullScreenCover(isPresented: $showingModal) { ColorDetailView(color: self.color) }
    }
}

struct ColorList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ColorList().environmentObject(ScreenState()).preferredColorScheme($0)
        }
    }
}
