//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import SwiftUI

///
/// <a href="https://system.design.orange.com/0c1af118d/p/7559da-sliders/b/253eea" target="_blank">ODS Slider</a>.
///
/// Based on the native `Slider`, the `ODSSLider` offers to the user the possibility
/// to type direcly on the slider's track to get a value.
///

// MARK: - Initializers with labels.
public struct ODSSlider<Label, ValueLabel, V> where V: BinaryFloatingPoint, V.Stride: BinaryFloatingPoint, Label: View, ValueLabel: View {

    // =======================
    // MARK: Stored properties
    // =======================

    @Binding private var value: V
    private let range: ClosedRange<V>
    private let label: Label
    private let minimumValueLabel: ValueLabel
    private let maximumValueLabel: ValueLabel
    private let onEditingChanged: (Bool) -> Void
    private let step: V.Stride?

    private let values: [V]?
    @State private var isEditing: Bool {
        didSet {
            onEditingChanged(isEditing)
        }
    }

    // ==================
    // MARK: Initializers
    // ==================

    /// Creates a slider to select a value from a given range, subject to a
    /// step increment, which displays the provided labels.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bounds: The range of the valid values. Defaults to `0...1`.
    ///   - step: The distance between each valid value.
    ///   - label: A `View` that describes the purpose of the instance. Not all
    ///     slider styles show the label, but even in those cases, SwiftUI
    ///     uses the label for accessibility. For example, VoiceOver uses the
    ///     label to identify the purpose of the slider.
    ///   - minimumValueLabel: A view that describes `bounds.lowerBound`.
    ///   - maximumValueLabel: A view that describes `bounds.upperBound`.
    ///   - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `bounds`.
    ///
    /// The slider calls `onEditingChanged` when editing begins and ends. For
    /// example, on iOS, editing begins when the user starts to drag the thumb
    /// along the slider's track.
    ///
    /// - Remark: Accessibilty recommendation:
    /// We recommand to not set information on `minimumValueLabel` and `maximumValueLabel` view using `.accessibilityHidden(true)`
    ///
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0 ... 1, @ViewBuilder label: () -> Label, @ViewBuilder minimumValueLabel: () -> ValueLabel, @ViewBuilder maximumValueLabel: () -> ValueLabel, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {

        _value = value
        range = bounds
        step = nil
        self.onEditingChanged = onEditingChanged
        self.label = label()
        self.minimumValueLabel = minimumValueLabel()
        self.maximumValueLabel = maximumValueLabel()

        values = nil
        _isEditing = State(initialValue: false)
    }

    /// Creates a slider to select a value from a given range, subject to a
    /// step increment, which displays the provided labels.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bounds: The range of the valid values.
    ///   - step: The distance between each valid value.
    ///   - label: A `View` that describes the purpose of the instance. Not all
    ///     slider styles show the label, but even in those cases, SwiftUI
    ///     uses the label for accessibility. For example, VoiceOver uses the
    ///     label to identify the purpose of the slider.
    ///   - minimumValueLabel: A view that describes `bounds.lowerBound`.
    ///   - maximumValueLabel: A view that describes `bounds.upperBound`.
    ///   - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `bounds`.
    ///
    /// The slider calls `onEditingChanged` when editing begins and ends. For
    /// example, on iOS, editing begins when the user starts to drag the thumb
    /// along the slider's track.
    ///
    /// - Remark: Accessibilty recommendation:
    /// We recommand to not set information on `minimumValueLabel` and `maximumValueLabel` view using `.accessibilityHidden(true)`
    ///
    public init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, @ViewBuilder label: () -> Label, @ViewBuilder minimumValueLabel: () -> ValueLabel, @ViewBuilder maximumValueLabel: () -> ValueLabel, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {

        _value = value
        range = bounds
        self.step = step
        self.onEditingChanged = onEditingChanged
        self.label = label()
        self.minimumValueLabel = minimumValueLabel()
        self.maximumValueLabel = maximumValueLabel()

        values = Array(stride(from: range.lowerBound, through: range.upperBound, by: step))
        _isEditing = State(initialValue: false)
    }
}

// MARK: - Initializers with label, without value labels.
extension ODSSlider where ValueLabel == EmptyView {

    /// Creates a slider to select a value from a given range, which displays
    /// the provided label.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bounds: The range of the valid values. Defaults to `0...1`.
    ///   - label: A `View` that describes the purpose of the instance. Not all
    ///     slider styles show the label, but even in those cases, SwiftUI
    ///     uses the label for accessibility. For example, VoiceOver uses the
    ///     label to identify the purpose of the slider.
    ///   - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `bounds`, mapped into `0...1`.
    ///
    /// The slider calls `onEditingChanged` when editing begins and ends. For
    /// example, on iOS, editing begins when the user starts to drag the thumb
    /// along the slider's track.
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0 ... 1, @ViewBuilder label: () -> Label, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(
            value: value,
            in: bounds,
            label: label,
            minimumValueLabel: { EmptyView() },
            maximumValueLabel: { EmptyView() },
            onEditingChanged: onEditingChanged)
    }

    /// Creates a slider to select a value from a given range, subject to a
    /// step increment. which displays the provided label.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bounds: The range of the valid values. Defaults to `0...1`.
    ///   - step: The distance between each valid value.
    ///   - label: A `View` that describes the purpose of the instance. Not all
    ///     slider styles show the label, but even in those cases, SwiftUI
    ///     uses the label for accessibility. For example, VoiceOver uses the
    ///     label to identify the purpose of the slider.
    ///   - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `bounds`.
    ///
    /// The slider calls `onEditingChanged` when editing begins and ends. For
    /// example, on iOS, editing begins when the user starts to drag the thumb
    /// along the slider's track.
    public init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, @ViewBuilder label: () -> Label, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(
            value: value,
            in: bounds,
            step: step,
            label: label,
            minimumValueLabel: { EmptyView() },
            maximumValueLabel: { EmptyView() },
            onEditingChanged: onEditingChanged)
    }
}

// MARK: - Initializers without labels.
extension ODSSlider where ValueLabel == EmptyView, Label == EmptyView {

    /// Creates a slider to select a value from a given range.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bounds: The range of the valid values. Defaults to `0...1`.
    ///   - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `bounds`, mapped into `0...1`.
    ///
    /// The slider calls `onEditingChanged` when editing begins and ends. For
    /// example, on iOS, editing begins when the user starts to drag the thumb
    /// along the slider's track.
    public init(value: Binding<V>, in bounds: ClosedRange<V> = 0 ... 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(
            value: value,
            in: bounds,
            label: { EmptyView() },
            minimumValueLabel: { EmptyView() },
            maximumValueLabel: { EmptyView() },
            onEditingChanged: onEditingChanged)
    }

    /// Creates a slider to select a value from a given range, subject to a
    /// step increment.
    ///
    /// - Parameters:
    ///   - value: The selected value within `bounds`.
    ///   - bounds: The range of the valid values.
    ///   - onEditingChanged: A callback for when editing begins and ends.
    ///
    /// The `value` of the created instance is equal to the position of
    /// the given value within `bounds`.
    ///
    /// The slider calls `onEditingChanged` when editing begins and ends. For
    /// example, on iOS, editing begins when the user starts to drag the thumb
    /// along the slider's track.
    public init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1, onEditingChanged: @escaping (Bool) -> Void = { _ in }) {
        self.init(
            value: value,
            in: bounds,
            step: step,
            label: { EmptyView() },
            minimumValueLabel: { EmptyView() },
            maximumValueLabel: { EmptyView() },
            onEditingChanged: onEditingChanged)
    }
}

// MARK: - View implementation.
extension ODSSlider: View {

    // ==========
    // MARK: Body
    // ==========

    public var body: some View {
        VStack {
            HStack(alignment: .center) {

                minimumValueLabel

                GeometryReader { geometry in
                    slider
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    let newValue = computeNewValue(for: value.location.x, in: geometry.size.width)
                                    if !isEditing {
                                        if newValue != self.$value.wrappedValue {
                                            self.isEditing = true
                                        }
                                    }

                                    self.$value.wrappedValue = newValue
                                }
                                .onEnded { value in
                                    self.$value.wrappedValue = computeNewValue(for: value.location.x, in: geometry.size.width)
                                    self.isEditing = false
                                }
                        )
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height,
                            alignment: .center)
                }

                maximumValueLabel
            }
        }
    }

    // =====================
    // MARK: private helpers
    // =====================
    @ViewBuilder
    var slider: some View {
        if let step = self.step {
            Slider(value: $value, in: range, step: step) {
                self.label
            }
        } else {
            Slider(value: $value, in: range) {
                self.label
            }
        }
    }

    private func computeNewValue(for xPosition: Double, in globalWidth: Double) -> V {
        if xPosition >= globalWidth {
            return range.upperBound
        } else {
            if xPosition <= 0 {
                return range.lowerBound
            } else {
                let percent = xPosition / globalWidth
                let computedValue = (V(percent) * (range.upperBound - range.lowerBound)) + range.lowerBound

                // Adjust newValue according to step
                return adjustNewValue(from: computedValue)
            }
        }
    }

    private func adjustNewValue(from computedValue: V) -> V {
        guard let values = values else {
            return computedValue
        }

        var newValue = computedValue
        var distance: V.Stride = .infinity

        for value in values {
            let newDistance = value.distance(to: computedValue)
            if abs(newDistance) < abs(distance) {
                distance = newDistance
                newValue = value
            } else {
                return newValue
            }
        }

        return newValue
    }
}

#if DEBUG
// MARK: - Previews.
struct ODSSlider_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            ODSSlider(
                value: .constant(50),
                in: 0 ... 100.0)
                .padding([.leading, .trailing], ODSSpacing.s)
        }
    }
}

struct ODSSlider_Previews_with_label: PreviewProvider {

    static var previews: some View {
        VStack {
            ODSSlider(value: .constant(50),
                      in: 0 ... 100.0) {
                Text("Spead")
            } minimumValueLabel: {
                Image(systemName: "speaker.wave.1.fill")
            } maximumValueLabel: {
                Image(systemName: "speaker.wave.3.fill")
            } onEditingChanged: { isEditing in
                print("isEditing(\(isEditing))")
            }
            .padding([.leading, .trailing], ODSSpacing.s)
        }
    }
}
#endif
