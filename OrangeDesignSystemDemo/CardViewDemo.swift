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

struct CardViewDemo: View {

    @State var eventOne: CardView_Control = .init()

    var body: some View {
        ScrollView {
            /* CardViewBis(image: "img_about", category: "Insider VSCO's Imaging LabImaging Imaging Imaging Imaging ", heading: "Insider VSCO's Imaging LabImaging Imaging Imaging Imaging", author: "Insider VSCO's Imaging LabImaging Imaging Imaging Imaging") */

            VStack(alignment: .leading, spacing: 15) {

                ODSCard {
                    CardComplexContent {
                        Image("img_about", bundle: Bundle.bundle)
                            .frame(width: .infinity, height: 180)
                            .fullWidthFrame()
                            .frame(alignment: .top)
                        // .frame(ma)
                        // .centerCropped()

                    } bottomContent: {
                        VStack(alignment: .leading) {
                            Text("With image Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging End.")
                                .fullWidthFrame()
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .frame(maxHeight: .infinity)
                            // .font(ODSFontStyle.bodyBold.font())
                            // .foregroundColor(ODSColor.coreThemeInverse.color)
                            // .fullWidthFrame()
                            Spacer(minLength: 0)
                            Text("Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging End.")
                                .fullWidthFrame()
                                .font(ODSFontStyle.bodyRegular.font())
                                .foregroundColor(ODSColor.coreThemeInverse.color)
                                .lineLimit(nil)
                                .frame(maxHeight: .infinity)

                            Button {
                                print("Action")
                            } label: {
                                ODSGenericButtonContent(topText: "Added to Siri", textColor: ODSColor.core_black_900.color)
                            }
                            .buttonStyle(ODSFilledButtonStyle())
                        }
                    }
                }.padding()
                /* CardViewBis(image: "img_about", category: "Insider VSCO's Imaging LabImaging Imaging Imaging Imaging ", heading: "Insider VSCO's Imaging LabImaging Imaging Imaging Imaging", author: "Insider VSCO's Imaging LabImaging Imaging Imaging Imaging") */
                CardView(backgroundImage: Image("img_about"), title: "Titre", subtitle: "", description: "", isShowDetail: false)
                    .frame(width: 165)
                    .environmentObject(eventOne)
                    .alert("Important message", isPresented: $eventOne.anyTriggered) {
                        Button("First") {}
                        Button("Second") {}
                        Button("Third") {}
                    }

                CardView(backgroundImage: Image("img_about"), title: "Titre", subtitle: "Subtitle", description: "", isShowDetail: false)
                    .frame(width: 165)
                    .environmentObject(CardView_Control())

                CardView(backgroundImage: Image("img_about"), title: "Titre", subtitle: "", description: "", isShowDetail: false)
                    .frame(width: 165)
                    .environmentObject(CardView_Control())

                // .frame(height: 500)
                CardView(backgroundImage: Image("img_about"), title: "Titre", subtitle: "Subtitle", description: "desPlaceholer LabImaging Imaging Imaging LabImaging Imaging Imaging LabImaging Imaging ImagingLabImaging Imaging Imaging", isShowDetail: false)
                    .environmentObject(CardView_Control()).padding()
                // .frame(height: 500)
            }
            .frame(width: UIScreen.main.bounds.width)
            // .frame(maxHeight: .infinity)
            Spacer()
        }
    }
}

#if DEBUG
struct CardViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemo()
            .previewInterfaceOrientation(.portrait)
        CardViewDemo()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3) // <- CONSTANT
    }
}
#endif

struct CardViewBis: View {
    var image: String
    var category: String
    var heading: String
    var author: String

    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)

            HStack {
                VStack(alignment: .leading) {
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(heading)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                    Text(author.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100)

                Spacer()
            }
            .padding()
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150 / 255, green: 150 / 255, blue: 150 / 255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}
