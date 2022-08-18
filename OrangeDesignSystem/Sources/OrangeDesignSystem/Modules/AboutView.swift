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

    @EnvironmentObject var applicationDescription: ApplicationDescription

    public var body: some View {

        List {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                Text("About")
                    .odsFont(.largeTitle)
                    .padding(.all, ODSSpacing.m)

                applicationDescription.imageHeader
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ApplicationDescriptionView()
                    .padding(.all, ODSSpacing.m)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())

            ODSAboutItemView()
        }
        .listStyle(PlainListStyle())
        .background(ODSColor.primaryBackground.color)
    }
}

public struct ODSAboutItem: Identifiable {
    //
    var odsType: ODSTypeLink = .navigation

    enum ODSTypeLink {
        case externalBrower
        case navigation
        case safariViewController
    }

    public init(text: String, nextView: AnyView) {
        self.text = text
        self.nextView = nextView
    }

    public init(text: String, nextView: AnyView, url: String) {
        self.init(text: text, nextView: nextView)
        self.url = url
        odsType = .externalBrower
    }

    public init(text: String, nextView: AnyView, safari: String) {
        self.init(text: text, nextView: nextView)
        url = safari
        odsType = .safariViewController
    }

    public var id: String {
        text
    }

    public var text: String
    public let nextView: AnyView
    public var url: String?
}

public class ApplicationDescription: ObservableObject {

    let applicationName: String
    let applicationVersion: String
    let applicationBuildNumber: String?
    let applicationBuildType: String?
    let copyrightNotice: String = "Orange property. All rights reserved"
    let imageHeader: Image

    public var menuList = [
        ODSAboutItem(text: "What's new", nextView: AnyView(Text("What's new application..."))),
        ODSAboutItem(text: "External web browser", nextView: AnyView(EmptyView()), url: "https://system.design.orange.com/"),
        ODSAboutItem(text: "Web view", nextView: AnyView(Text("Error View")), safari: "https://system.design.orange.com/"),
    ]

    public init(applicationName: String, applicationVersion: String, applicationBuildNumber: String? = nil, applicationBuildType: String? = nil, imageHeader: Image = Image("img_about", bundle: Bundle.ods)) {
        self.applicationName = applicationName
        self.applicationVersion = applicationVersion
        self.applicationBuildType = applicationBuildType
        self.applicationBuildNumber = applicationBuildNumber
        self.imageHeader = imageHeader
    }
}

public struct ODSAboutItemView: View {

    @State private var showSafari = false
    @EnvironmentObject var applicationDescription: ApplicationDescription

    public init() {}

    public var body: some View {
        ForEach(applicationDescription.menuList) { item in

            switch item.odsType {
            case .navigation:
                NavigationLink(destination: item.nextView) {
                    HStack {
                        Text(item.text).odsFont(.bodyBold)
                    }
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: ODSSpacing.xxl,
                           maxHeight: .infinity,
                           alignment: .leading)
                }

            case .externalBrower:
                if let url = item.url, let urlDestination = URL(string: url) {
                    Link(destination: urlDestination) {
                        HStack {
                            Text(item.text).odsFont(.bodyBold)
                        }
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: ODSSpacing.xxl,
                               maxHeight: .infinity,
                               alignment: .leading)
                    }
                }

            case .safariViewController:
                if let url = item.url, let urlDestination = URL(string: url) {
                    Button {
                        showSafari.toggle()
                    } label: {
                        Text(item.text).odsFont(.bodyBold)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   minHeight: ODSSpacing.xxl,
                                   maxHeight: .infinity,
                                   alignment: .leading)
                    }
                    .sheet(isPresented: $showSafari) {
                        ODSSFSafariViewWrapper(url: urlDestination)
                    }
                }
            }
        }
    }
}

private struct ApplicationDescriptionView: View {

    @EnvironmentObject var applicationDescription: ApplicationDescription

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(applicationDescription.applicationName).odsFont(.largeTitle)
            Text("Version \(applicationDescription.applicationVersion)")
            if let buildNumber = applicationDescription.applicationBuildNumber {
                Text("Build \(buildNumber)")
            }
            if let buildType = applicationDescription.applicationBuildType {
                Text(buildType)
            }

            Text(applicationDescription.copyrightNotice)
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        let applicationDescription = ApplicationDescription(applicationName: "APP NAME", applicationVersion: "1.0.0", applicationBuildNumber: "123456789", applicationBuildType: "PREVIEW")

        ForEach(ColorScheme.allCases, id: \.self) {

            AboutView()
                .preferredColorScheme($0)
                .environmentObject(applicationDescription)
        }
    }
}
