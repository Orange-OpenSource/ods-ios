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

    let listModel = ODSListModel(title: "CardViewDemo",
                                 cards: [ODSCardModel(title: "Sandbox", image: "empty") {
                                     CardViewDemoSandbox()
                                 },
                                 ODSCardModel(title: "List", image: "empty") {
                                     CardViewDemoList()
                                 },
                                 ODSCardModel(title: "Grid", image: "empty") {
                                     CardViewDemoGrid()
                                 }])
    var body: some View {
        ListCardView().environmentObject(listModel)
    }
}

struct CardViewDemoGrid: View {
    let cards = (1 ... 20).map { ODSCardModel(title: "Title \($0)", image: "empty") }

    let columns = [
        GridItem(.adaptive(minimum: 150.0), alignment: .topLeading),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(cards, id: \.title) { item in
                    NavigationLink(destination: EmptyView()) {
                        ODSCardView(element: item)
                    }
                }
                .padding([.trailing])
            }
        }
        .padding([.leading, .top, .bottom])
        .navigationTitle("Page title")
        .navigationViewStyle(.stack)
        .background(Color(uiColor: .systemGray5))
    }
}

struct CardViewDemoList: View {
    let cards = (1 ... 40).map { ODSCardModel(title: "Title \($0)", image: "empty", subTitle: "SubTitle \($0)", description: "Description \($0)") }

    var body: some View {
        let model = ODSListModel(title: "CardViewDemo List", cards: cards)
        ListCardView().environmentObject(model)
    }
}

struct CardViewDemoSandbox: View {

    @StateObject private var eventOne = ODSCardView_Control()

    var body: some View {
        ScrollView {
            // let size = UIScreen.main.bounds.size.width / 2 - (ODSDim.padding * 2)
            VStack(alignment: .leading, spacing: 15) {

                let minimal = ODSCardModel(title: "titre", image: "empty")

                let sample2 = ODSCardModel(title: "titre", image: "empty", subTitle: "desPlaceholer LabImaging", description: "Lorem ipsum dolor sit amet, at blandit nec tristique porttitor.")

                NavigationLink(destination: ShapeButtonsList()) {
                    ODSCardView(element: ODSCardModel.example)
                        .environmentObject(ODSCardView_Control())
                        .padding()
                }

                CardViewCustom(element: ODSCardModel.example) {
                    Group {
                        Spacer()
                        Button {
                            print("Action")
                        } label: {
                            ODSGenericButtonContent(topText: "Added to Siri", textColor: ODSColor.coreBlack.color)
                        }
                        .buttonStyle(ODSFilledButtonStyle())
                    }
                }
                .environmentObject(ODSCardView_Control())
                .padding()

                CardViewCustom(element: minimal) {
                    Group {
                        Spacer()
                        NavigationLink(destination: ShapeButtonsList()) {
                            ODSGenericButtonContent(topText: "Added to Siri")
                        }.buttonStyle(ODSBorderedButtonStyle())
                    }
                }
                .environmentObject(ODSCardView_Control())
                .padding()

                ODSCardView(element: ODSCardModel.exampleMultiline)
                    .environmentObject(eventOne).alert("Important message", isPresented: $eventOne.anyTriggered) {
                        Button("First") {}
                        Button("Second") {}
                        Button("Third") {}
                    }.padding()

                let sample1 = ODSCardModel(title: "titre", image: "empty", subTitle: "Description")

                ODSCardView(element: sample1)
                    .environmentObject(ODSCardView_Control())
                    .padding()

                ODSCardView(element: sample2)
                    .environmentObject(ODSCardView_Control())
                    .frame(width: 160)
                    .padding()

                ODSCardView(element: sample2)
                    .frame(width: 165)
                    .environmentObject(ODSCardView_Control())
                    .padding()

                ODSCardView(element: sample2)
                    .frame(width: 165)
                    .environmentObject(ODSCardView_Control())
                    .padding()

                ODSCardView(element: sample2)
                    .environmentObject(ODSCardView_Control())
                    .padding()
            }
            .background(Color(uiColor: .systemGray5))
            .frame(width: UIScreen.main.bounds.width)
            // .frame(maxHeight: .infinity)
            Spacer()
        }.navigationTitle("SandBox")
            .background(Color(uiColor: .systemGray5))
    }
}

#if DEBUG
struct CardViewDemoGrid_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemoGrid()
            .previewInterfaceOrientation(.portrait)
        CardViewDemoGrid()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3) // <- CONSTANT
    }
}

struct CardViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemo()
            .previewInterfaceOrientation(.portrait)
    }
}

struct CardViewDemoList_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemoList()
            .previewInterfaceOrientation(.portrait)
        CardViewDemoList()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3) // <- CONSTANT
    }
}

struct CardViewDemoSandBox_Previews: PreviewProvider {
    static var previews: some View {
        //
        CardViewDemoSandbox()
            .previewInterfaceOrientation(.portrait)
        CardViewDemoSandbox()
            .previewInterfaceOrientation(.portrait)
            .environment(\.dynamicTypeSize, .accessibility3) // <- CONSTANT
    }
}

#endif
