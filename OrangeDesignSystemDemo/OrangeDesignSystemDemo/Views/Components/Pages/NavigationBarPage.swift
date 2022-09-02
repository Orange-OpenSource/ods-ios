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

struct NavigationBarPage: View {

    var body: some View {

        List {
            VStack {
                Image("Navigation bars")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ComponentDescription(text: "A navigation bar appears at the top of an app screen, below the status bar, and enables navigation through a series of hierarchical screens.")
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.l)
                VariantsTitle()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.m)
            }
            .listRowInsets(EdgeInsets())
            .padding(.horizontal, ODSSpacing.none)

            NavigationLink {
                NavigationBarStandard()
            } label: {
                ODSListItem(model: ODSListItemModel(title: "Standard"))
            }

            NavigationLink {
                NavigationBarLargeTitle()
            } label: {
                ODSListItem(model: ODSListItemModel(title: "Large title"))
            }

            NavigationLink {
                NavigationBarWithSearchBar()
            } label: {
                ODSListItem(model: ODSListItemModel(title: "With search bar"))
            }

            NavigationLink {
                NavigationBarWithActionItem()
            } label: {
                ODSListItem(model: ODSListItemModel(title: "With action item"))
            }
        }
        .listRowSeparator(Visibility.visible)
        .listStyle(.plain)
        .padding(.top, ODSSpacing.none)
        .padding(.bottom, ODSSpacing.m)
        .background(ODSColor.componentBackground2.color)
    }
}

struct ListExample: View {
    var body: some View {
        List {
            ForEach(1 ... 10, id: \.self) { i in
                Text("Item #\(i)")
            }.listRowInsets(.init(top: 20,
                                  leading: 20,
                                  bottom: 20,
                                  trailing: 20))
        }.listStyle(.plain)
    }
}

struct NavigationBarStandard: View {

    var body: some View {
        ListExample()
            .navigationBarTitle("Standard", displayMode: .inline)
    }
}

struct NavigationBarLargeTitle: View {

    var body: some View {
        ListExample()
            .navigationTitle("Large title")
    }
}

struct NavigationBarWithSearchBar: View {

    @State var searchQuery = ""

    var body: some View {
        ListExample()
            .navigationBarTitle("With search bar", displayMode: .inline)
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
    }
}

struct NavigationBarWithActionItem: View {
    @State private var showAlert = false

    var body: some View {
        ListExample()
            .navigationBarTitle("With action item", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                    .alert("item action", isPresented: $showAlert) {
                        Button("close", role: .cancel) {}
                    }
                }
            }
    }
}

#if DEBUG
struct NavigationBarPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationBarPage()
                .previewInterfaceOrientation(.portrait)
        }

        NavigationView {
            NavigationBarPage()
                .previewInterfaceOrientation(.portrait)
                .environment(\.dynamicTypeSize, .accessibility3)
        }
    }
}
#endif
