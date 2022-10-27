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

public struct AboutView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject var applicationDescription: ApplicationDescription

    // ==================
    // MARK: Initializers
    // ==================

    public init() {}

    // ==================
    // MARK: Body
    // ==================

    public var body: some View {
        List {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {
                Text("About")
                    .odsFont(.largeTitle)
                    .padding(.all, ODSSpacing.m)

                applicationDescription.imageHeader
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityHidden(true)

                ApplicationDescriptionView()
                    .padding(.all, ODSSpacing.m)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())

            ODSAboutItemView()
        }
        .listStyle(PlainListStyle())
        .background(ODSInternalColor.primaryBackground.color)
    }
}

public struct ODSAboutItem: Identifiable {

    // =======================
    // MARK: Stored Properties
    // =======================

    public let odsType: ODSTypeLink
    public let text: String
    public let nextView: AnyView
    public let url: String?

    public enum ODSTypeLink {
        case externalBrower
        case navigation
        case safariViewController
    }

    // ==================
    // MARK: Initializers
    // ==================

    public init(text: String, nextView: AnyView) {
        self.text = text
        self.nextView = nextView
        self.odsType = .navigation
        self.url = nil
    }

    public init(text: String, nextView: AnyView, url: String) {
        self.text = text
        self.nextView = nextView
        self.url = url
        self.odsType = .externalBrower
    }

    public init(text: String, nextView: AnyView, safari: String) {
        self.text = text
        self.nextView = nextView
        self.url = safari
        self.odsType = .safariViewController
    }

    public var id: String {
        text
    }
}

public class ApplicationDescription: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    public let applicationName: String
    public let applicationVersion: String
    public let applicationBuildNumber: String?
    public let applicationBuildType: String?
    public let copyrightNotice: String = "Orange property. All rights reserved"
    public let imageHeader: Image

    public var menuList = [
        ODSAboutItem(text: "What's new", nextView: AnyView(Text("What's new application..."))),
        ODSAboutItem(text: "External web browser", nextView: AnyView(EmptyView()), url: "https://system.design.orange.com/"),
        ODSAboutItem(text: "Web view", nextView: AnyView(Text("Error View")), safari: "https://system.design.orange.com/"),
    ]

    // ==================
    // MARK: Initializers
    // ==================

    public init(applicationName: String, applicationVersion: String, applicationBuildNumber: String? = nil, applicationBuildType: String? = nil, imageHeader: Image = Image("img_about", bundle: Bundle.ods)) {
        self.applicationName = applicationName
        self.applicationVersion = applicationVersion
        self.applicationBuildType = applicationBuildType
        self.applicationBuildNumber = applicationBuildNumber
        self.imageHeader = imageHeader
    }
}

public struct ODSAboutItemView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State private var showSafari = false
    @EnvironmentObject var applicationDescription: ApplicationDescription

    // ==================
    // MARK: Initializers
    // ==================

    public init() {}

    // =======================
    // MARK: Body
    // =======================

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

    // =======================
    // MARK: Stored Properties
    // =======================

    @EnvironmentObject var applicationDescription: ApplicationDescription

    // =======================
    // MARK: Body
    // =======================

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(applicationDescription.applicationName)
                .odsFont(.largeTitle)
                .fixedSize(horizontal: false, vertical: true)

            Text("Version \(applicationDescription.applicationVersion)")
                .fixedSize(horizontal: false, vertical: true)

            if let buildNumber = applicationDescription.applicationBuildNumber {
                Text("Build \(buildNumber)")
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let buildType = applicationDescription.applicationBuildType {
                Text(buildType)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Text(applicationDescription.copyrightNotice)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#if DEBUG
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
#endif
