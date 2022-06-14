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

// =============
// MARK: Models
// =============
public enum ODSListItemLeftIconModel {
    case withImage(Image)
    case withUrl(URL, Image)
}

public enum ODSListItemRightIconModel {
    case text(String)
    case toggle(Binding<Bool>)
}

public enum ODSListItemMinHeight: CGFloat {
    case medium = 44.0
    case large = 60.0
}

public struct ODSListItemModel: Identifiable {

    public var id: UUID
    public let title: String
    public let subtitle: String?
    public let leftIconModel: ODSListItemLeftIconModel?
    public let rightIconModel: ODSListItemRightIconModel?
    public let minHeight: ODSListItemMinHeight

    public init(
        title: String,
        subtitle: String? = nil,
        leftIconModel: ODSListItemLeftIconModel? = nil,
        rightIconModel: ODSListItemRightIconModel? = nil,
        minHeight: ODSListItemMinHeight = .medium)
    {
        self.title = title
        self.subtitle = subtitle
        self.leftIconModel = leftIconModel
        self.rightIconModel = rightIconModel
        self.minHeight = minHeight

        id = UUID()
    }
}

// ============
// MARK: Views
// ============
public struct ODSListItem: View {

    let model: ODSListItemModel

    public var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if let lestIconModel = model.leftIconModel {
                ODSListItemLeftIcon(iconModel: lestIconModel, iconHeight: model.minHeight.rawValue)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(model.title))
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)

                if let subtitle = model.subtitle {
                    Text(LocalizedStringKey(subtitle))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.vertical, 8)

            Spacer()

            if let rightIconModel = model.rightIconModel {
                ODSListItemRightIcon(iconModel: rightIconModel)
            }
        }
        .modifier(ODSListItemModifier(minHeight: model.minHeight))
    }

    public init(model: ODSListItemModel) {
        self.model = model
    }
}
