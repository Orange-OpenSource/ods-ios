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
import SwiftUI

public struct AboutView: View {

    public init() {}

    public var body: some View {
        List {
            VStack(alignment: .leading) {
                Text("About").odsFont(style: .largeTitle)
                Image("img_about", bundle: Bundle.bundle)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, -16)
                ApplicationDescriptionView()
            }.listRowSeparator(.hidden)
            MenuList()
        }.listStyle(GroupedListStyle())
    }
}

public class ApplicationDescription: ObservableObject {

    let applicationName: String
    let applicationVersion: String
    let copyrightNotice = "Orange property. All rights reserved"

    public init(applicationName: String, applicationVersion: String) {
        self.applicationName = applicationName
        self.applicationVersion = applicationVersion
    }
}

public struct MenuList: View {

    public init() {}

    public var body: some View {
        NavigationLink("What's new", destination: Text("Hello"))
        NavigationLink("Legal information", destination: Text("Hello"))
        NavigationLink("General terms of use", destination: Text("Hello"))
        NavigationLink("Privacy information", destination: Text("Hello"))
    }
}

private struct ApplicationDescriptionView: View {

    @EnvironmentObject var applicationDescription: ApplicationDescription

    var body: some View {
        Text(applicationDescription.applicationName).odsFont(style: .largeTitle)
        Text("Version  \(applicationDescription.applicationVersion)").odsFont(style: .bodyRegular)
        Text(applicationDescription.copyrightNotice).odsFont(style: .bodyRegular)
    }
}
