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

    @EnvironmentObject var applicationInformation: ApplicationInformation

    // ==================
    // MARK: Initializers
    // ==================

    public init() {}

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        List {
            VStack(alignment: .leading, spacing: ODSSpacing.none) {

                applicationInformation.imageHeader
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .accessibilityHidden(true)

//                ApplicationInformationView()
//                    .padding(.all, ODSSpacing.m)

            }
            .listRowInsets(EdgeInsets())

            ODSAboutItemView()
        }
        .listStyle(PlainListStyle())
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.large)
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

public class ApplicationInformation: ObservableObject {

    // =======================
    // MARK: Stored Properties
    // =======================

    public let name: String
    public let version: String
    public let buildNumber: String?
    public let buildType: String?
    public let description: String?
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

    public init(name: String, version: String, buildNumber: String? = nil, buildType: String? = nil, description: String? = nil, imageHeader: Image = Image("img_about", bundle: Bundle.ods)) {
        self.name = name
        self.version = version
        self.buildType = buildType
        self.buildNumber = buildNumber
        self.description = description
        self.imageHeader = imageHeader
    }
}

public struct ODSAboutItemView: View {

    // =======================
    // MARK: Stored Properties
    // =======================

    @State private var showSafari = false
    @EnvironmentObject var applicationInformation: ApplicationInformation

    // ==================
    // MARK: Initializers
    // ==================

    public init() {}

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        ForEach(applicationInformation.menuList) { item in

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
