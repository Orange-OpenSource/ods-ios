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

public struct ODSAboutListItem: Identifiable, View {

    // =======================
    // MARK: Stored Properties
    // =======================

    private let model: ODSListStandardItemModel
    private let target: Target

    private enum Target {
        case destination(AnyView)
        case action(() -> Void)
    }

    // ==================
    // MARK: Initializers
    // ==================

    private init(title: String, subtitle: String? = nil, icon: Image? = nil, target: Target) {
        model = ODSListStandardItemModel(title: title, subtitle: subtitle, leadingIcon: ODSListItemLeadingIcon(icon: icon))
        self.target = target
    }

    public init(title: String, subtitle: String? = nil, icon: Image? = nil, action: @escaping () -> Void) {
        self.init(title: title, subtitle: subtitle, icon: icon, target: .action(action))
    }
    public init(title: String, subtitle: String? = nil, icon: Image? = nil, destination: AnyView) {
        self.init(title: title, subtitle: subtitle, icon: icon, target: .destination(destination))
    }
    public init<Destination>(title: String, subtitle: String? = nil, icon: Image? = nil, @ViewBuilder destinationB: () -> Destination) where Destination: View {
        self.init(title: title, subtitle: subtitle, icon: icon, target: .destination(AnyView(destinationB())))
    }

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        switch self.target {
        case .action(let action):
            Button {
                action()
            } label: {
                ODSListStandardItem(model: self.model)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            
        case .destination(let destination):
            NavigationLink(model) { destination.navigationTitle(model.title) }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            
        }
    }
    
    // ============
    // MARK: Helper
    // ============
    
    public var id: UUID {
        model.id
    }
}

extension ODSListItemLeadingIcon {
    init?(icon: Image?) {
        guard let icon = icon else {
            return nil
        }
        self = .icon(icon)
    }
}

