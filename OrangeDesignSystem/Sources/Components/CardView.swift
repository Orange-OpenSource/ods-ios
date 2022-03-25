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

import Combine
import SwiftUI

public struct Card {
    let prompt: String
    let answer: String

    let image: Image? = nil
    let title: String? = nil
    let subTitle: String? = nil

    public static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}

/*
 public struct CardView: View {
     public let card: Card
     @State private var isShowingAnswer = false

     public init(card: Card) {
         self.card = card
     }

     public var body: some View {
         ZStack {
             RoundedRectangle(cornerRadius: 25, style: .continuous)
                 .fill(.white)
                 .shadow(radius: 10)

             VStack {
                 Text(card.prompt)
                     .font(.largeTitle)
                     .foregroundColor(.black)

                 if isShowingAnswer {
                     Text(card.answer)
                         .font(.title)
                         .foregroundColor(.gray)
                 }
             }
             .padding(20)
             .multilineTextAlignment(.center)
         }
         .frame(width: 450, height: 250)
         .onTapGesture {
             isShowingAnswer.toggle()
         }
     }
 }

 #if DEBUG
 struct CardView_Previews: PreviewProvider {
     static var previews: some View {
         CardView(card: Card.example)
     }
 }
 #endif
 */

open class CardView_Control: ObservableObject {
    public init() {}

    @Published public var anyTriggered = false
}

public struct CardView: View {
    var backgroundImage: Image
    var title: String
    var subtitle: String
    var description: String

    @State var isShowDetail = false
    @EnvironmentObject var control: CardView_Control

    public init(backgroundImage: Image, title: String, subtitle: String, description: String, isShowDetail: Bool) {
        self.title = title
        self.subtitle = subtitle
        self.backgroundImage = backgroundImage
        self.description = description
        self.isShowDetail = isShowDetail
    }

    public var body: some View {

        CardInnerView(backgroundImage: self.backgroundImage, title: self.title, subtitle: self.subtitle, description: self.description, isShow: self.$isShowDetail)
            .onTapGesture {
                // withAnimation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1)) {

                self.control.anyTriggered.toggle()
                // }
            }
            // .frame(minHeight: 300, maxHeight: .infinity)
            // .fixedSize(horizontal: true, vertical: false)
            // .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            // .frame(height: 270)
            /* VStack(alignment: .center, spacing: 0) {
                 TopView(subtitle: self.subtitle, title: self.title, backgroundImage: self.backgroundImage, briefSummary: self.briefSummary, isShow: self.$isShowDetail)
                 // .frame(minHeight: 270, maxHeight: .infinity)

                 if !self.briefSummary.isEmpty {
                     HStack(spacing: 0) {
                         Text(self.briefSummary)
                             .font(ODSFontStyle.bodyRegular.font())
                             .foregroundColor(ODSColor.core_black_900.color)
                             .lineLimit(4)
                         Spacer()
                     }
                     .padding()
                 }
             } */
            .cornerRadius(10)
            /* .overlay(
             RoundedRectangle(cornerRadius: 10)
                 .stroke(ODSColor.grey200.color, lineWidth: 1)) */
            .shadow(color: ODSColor.grey600.color, radius: 3)
        // .padding([.top, .horizontal, .bottom])
        // .background(ODSColor.core_white_100.color)
        // .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        // .shadow(radius: 10)

        // .frame(minHeight: 0, maxHeight: .infinity)
        // .frame(width: UIScreen.main.bounds.width - 40)
        // .frame(height: 300)
        // .fixedSize(horizontal: true, vertical: false)
        // .offset(x: control.anyTriggered && !isShowDetail ? UIScreen.main.bounds.width : 0)
        // .opacity(control.anyTriggered && !isShowDetail ? 0 : 1)
        // .shadow(radius: 2)
    }

    /* public var body: some View {
         VStack {
             Image("img_about", bundle: Bundle.bundle)
                 .centerCropped()
                 .frame(height: 190)

             HStack {
                 VStack(alignment: .leading) {
                     Text(self.title)
                         .font(ODSFontStyle.bodyBold.font())
                         .foregroundColor(ODSColor.core_black_900.color)
                     if !self.isShowDetail {
                         Text(self.subtitle)
                             .font(ODSFontStyle.bodyRegular.font())
                             .foregroundColor(ODSColor.core_black_900.color)
                     }
                 }
                 .layoutPriority(100)

                 Spacer()
             }
             .padding()
         }
         .onTapGesture {
             // withAnimation(.interpolatingSpring(mass: 1, stiffness: 90, damping: 15, initialVelocity: 1)) {
             self.isShowDetail.toggle()
             self.control.anyTriggered.toggle()
             // }
         }
         .cornerRadius(10)
         .overlay(
             RoundedRectangle(cornerRadius: 10)
                 .stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.1), lineWidth: 1)
         )
         .shadow(radius: 2)
         .padding([.top, .horizontal])
     } */
}

struct CardInnerView: View {
    var backgroundImage: Image
    var title: String
    var subtitle: String
    var description: String

    @Binding var isShow: Bool
    @State private var translation = CGSize.zero

    var body: some View {

        VStack(alignment: .center, spacing: 0) {
            /* TopView(subtitle: self.subtitle, title: self.title, backgroundImage: self.backgroundImage, briefSummary: self.briefSummary, isShow: self.$isShow) */
            // .frame(minHeight: 0, maxHeight: .infinity)

            VStack(alignment: .center, spacing: 0) {

                ZStack {
                    Image("img_about", bundle: Bundle.bundle)
                        .centerCropped()
                        //
                        // .frame(height: 185)
                        .frame(minHeight: 90, maxHeight: 190)
                }
                // Spacer()
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(self.title)
                            .font(ODSFontStyle.bodyBold.font())
                            .foregroundColor(ODSColor.coreThemeInverse.color)
                            .lineLimit(nil)
                        if !self.subtitle.isEmpty {
                            Text(self.subtitle)
                                .font(ODSFontStyle.bodyRegular.font())
                                .foregroundColor(ODSColor.coreThemeInverse.color)
                                .lineLimit(nil)
                        }
                    }

                    Spacer()
                }
                .padding()
            }

            if !self.description.isEmpty {
                HStack(spacing: 0) {
                    Text(self.description)
                        .font(ODSFontStyle.bodyRegular.font())
                        .foregroundColor(ODSColor.coreThemeInverse.color)
                        .lineLimit(nil)
                    Spacer()
                }
                .padding()
            }
        }
        .background(ODSColor.coreTheme.color)
    }
}

struct TopView: View {
    var subtitle: String
    var title: String
    var backgroundImage: Image
    var briefSummary: String

    @Binding var isShow: Bool

    var body: some View {

        VStack(alignment: .center, spacing: 0) {

            ZStack {
                Image("img_about", bundle: Bundle.bundle)
                    .centerCropped()
                // .frame(height: 190)
            }
            // Spacer()
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(self.title)
                        .font(ODSFontStyle.bodyBold.font())
                        .foregroundColor(ODSColor.core_black_900.color)
                        .lineLimit(nil)
                    if !self.isShow {
                        Text(self.subtitle)
                            .font(ODSFontStyle.bodyRegular.font())
                            .foregroundColor(ODSColor.core_black_900.color)
                            .lineLimit(nil)
                    }
                }

                Spacer()
            }
            .padding()
        }
        // .fixedSize(horizontal: true, vertical: false)
    }
}

#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(backgroundImage: Image("img_about"), title: "titre", subtitle: "Subtitle", description: "desPlaceholer LabImaging Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging Imaging", isShowDetail: false)
                .environmentObject(CardView_Control())

            CardView(backgroundImage: Image("img_about"), title: "titre", subtitle: "Subtitle", description: "desPlaceholer LabImaging Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging Imaging", isShowDetail: false)
                .environmentObject(CardView_Control())

            CardView(backgroundImage: Image("img_about"), title: "titre", subtitle: "Subtitle", description: "desPlaceholer LabImaging Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging Imaging", isShowDetail: false)
                .environmentObject(CardView_Control())
                .frame(width: 160, height: 175)

//            CardView(subtitle: "MEET THE DEVELOPER", title: "Insider VSCO's Imaging Lab", backgroundImage: Image("bg1"), briefSummary: "How VSCO brings analog authenticity to your digital shots", description: desPlaceholer, isShowDetail: true)
//
//            TopView(subtitle: "MEET THE DEVELOPER", title: "Insider VSCO's Imaging Lab", backgroundImage: Image("bg1"), briefSummary: "How VSCO brings analog authenticity to your digital shots")
//                .background(Color.black)
        }
    }
}
#endif
