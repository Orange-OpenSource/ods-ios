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

import SwiftUI

// swiftlint:disbale comment_spacing multiline_parameters_brackets vertical_parameter_alignment
public enum ODSBottomSheetSize: String, CaseIterable {
    case hidden /// The state where the BottomSheet is hidden
    case small /// The state where the BottomSheet is closed (`mainContent` is hidden)
    case medium /// The state where the height of the BottomSheet is 50% of the screen
    case large /// The state where the height of the BottomSheet is 90% of the screen
}

extension View {
    ///
    /// <a href="https://system.design.orange.com/0c1af118d/p/3347ca-sheets-bottom/b/83b619" target="_blank">ODS Sheet Bottom</a>.
    ///
    /// Bottom sheets are surfaces anchored to the bottom of the screen that present users supplemental content.
    /// It is useful for requesting a specific information or enabling a simple task related to the current context
    /// of the current view or more globaly the application context.
    ///
    /// Unlike the standard bottom sheet __odsBottomSheetExpanding__  proposes open and close states, the expanding bottom sheet supports
    /// multiple sizes or detents (small, medium and large). So a more complex and scrollable content can be proposed.
    ///
    /// The sheet expands when the user scrolls its contents, drags up or down the grabber (in header). A user can also tap the grabber to cycle
    /// through the available sizes.
    ///
    /// This modifier adds a bottom sheet containing only title in header and a complex content.
    /// It opens the sheet in the size provided by the initial value of a binding to a __ODSBottomSheetSize__ value.
    /// The value is updated, when the sheet is expanded or closed (by swiping the content, tapping on header, tapping on dimming area, ...)
    ///
    /// The example below shows how to present a bottom sheet:
    ///
    ///     struct BottomSheetPresentation: View {
    ///         @State private var bottomSheetSize: ODSBottomSheetSize = .large
    ///
    ///         var body: some View {
    ///             VStack {
    ///                 // Main content goes here.
    ///                 Text("Bottom sheet size \(bottomSheetSize.rawValue)")
    ///             }
    ///             .odsBottomSheetExpanding(title: "Customize", bottomSheetSize: $bottomSheetSize) {
    ///                 // Bottom sheet content goes here
    ///             }
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - title: The title added in the header.
    ///   - bottomSheetSize: A binding to __ODSBottomSheetSize__ value that determines
    ///     the size of the sheet that you create in the modifier's `content` closure.
    ///   - content: A closure that returns the content of the bottom sheet.
    ///
    public func odsBottomSheetExpanding<Content: View> (
        title: String,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
            self.modifier(ODSBottomSheetExpandingModifier(
                title: title,
                subtile: nil,
                icon: nil,
                bottomSheetSize: bottomSheetSize,
                content: content))
        }

    /// This modifier adds a bottom sheet containing title and subtitle in header and a complex content.
    ///
    /// - Parameters:
    ///   - title: The title added in the header.
    ///   - subtitle: The additionnal subtitle added in the header.
    ///   - bottomSheetSize: A binding to __ODSBottomSheetSize__ value that determines
    ///     the size of the sheet that you create in the modifier's `content` closure.
    ///   - content: A closure that returns the content of the bottom sheet.
    ///
    public func odsBottomSheetExpanding<Content: View> (
        title: String,
        subtitle: String,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
            self.modifier(ODSBottomSheetExpandingModifier(
                title: title,
                subtile: subtitle,
                icon: nil,
                bottomSheetSize: bottomSheetSize,
                content: content))
        }

    /// This modifier adds a bottom sheet containing title and icon in header and a complex content.
    ///
    /// - Parameters:
    ///   - title: The title added in the header.
    ///   - icon: The additional icon added near to the title in header.
    ///   - bottomSheetSize: A binding to __ODSBottomSheetSize__ value that determines
    ///     the size of the sheet that you create in the modifier's `content` closure.
    ///   - content: A closure that returns the content of the bottom sheet.
    ///
    public func odsBottomSheetExpanding<Content: View> (
        title: String,
        icon: Image,
        bottomSheetSize: Binding<ODSBottomSheetSize>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
            self.modifier(ODSBottomSheetExpandingModifier(
                title: title,
                subtile: nil,
                icon: icon,
                bottomSheetSize: bottomSheetSize,
                content: content))
        }
}
