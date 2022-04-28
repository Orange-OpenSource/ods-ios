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

struct GuidelinesList: View {

    @ObservedObject var screenState = ScreenState()

    var body: some View {
        let listModel = ODSListCardViewModel(title: "Guidelines",
                                             cards: [
                                                 ODSCardModel(title: "Colours", image: "Colour") {
                                                     ColorList().environmentObject(self.screenState)
                                                 },
                                                 ODSCardModel(title: "Typography", image: "Typography") {
                                                     FontList()
                                                 },
                                                 ODSCardModel(title: "Imagery", image: "Imagery") {
                                                     Text("[see design system web site](https://system.design.orange.com/0c1af118d/p/73d2a9-imagery)")
                                                 },
                                                 ODSCardModel(title: "Iconography", image: "Iconography") {
                                                     Text("[see design system web site](https://system.design.orange.com/0c1af118d/p/354f64-iconography/b/80118e)")
                                                 },
                                             ])
        return NavigationView {
            ODSListCardView()
                .environmentObject(listModel)
                .background(Color(uiColor: .systemGray5))
        }
    }
}

struct GuidelinesListView_Previews: PreviewProvider {
    static var previews: some View {
        GuidelinesList()
    }
}
