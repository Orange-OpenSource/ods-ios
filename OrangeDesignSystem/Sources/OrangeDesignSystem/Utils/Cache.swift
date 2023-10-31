//
// Software Name: Orange Design System (iOS)
// SPDX-FileCopyrightText: Copyright (c) 2021 - 2023 Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license.
//

import Foundation

/// Allows to store inside `NSCache` some objects which won't be removed when the application goes to background
final class Cache<Key: Hashable, Value>: NSObject, NSCacheDelegate {

    // ==================
    // MARK: - Properties
    // ==================

    private let cache = NSCache<KeyWrapper, Entry>()

    // =================
    // MARK: - Lifecycle
    // =================

    override init() {
        super.init()
        cache.delegate = self
    }

    deinit {
        cache.delegate = nil
    }

    // ===============
    // MARK: - Service
    // ===============

    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            if let value = newValue {
                setValue(value, forKey: key)
            } else {
                removeValue(forKey: key)
            }
        }
    }

    func setValue(_ value: Value, forKey key: Key) {
        let entry = Entry(value)
        cache.setObject(entry, forKey: KeyWrapper(key))
    }

    func value(forKey key: Key) -> Value? {
        return cache.object(forKey: KeyWrapper(key))?.value as? Value
    }

    func removeValue(forKey key: Key) {
        cache.removeObject(forKey: KeyWrapper(key))
    }

    func removeAllValues() {
        cache.removeAllObjects()
    }

    // ===================
    // MARK: - Key Wrapper
    // ===================

    final class KeyWrapper: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int {
            return key.hashValue
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let wrapper = object as? KeyWrapper else {
                return false
            }

            return wrapper.key == key
        }
    }

    // =============
    // MARK: - Entry
    // =============

    final class Entry: NSDiscardableContent {
        let value: Value

        init(_ value: Value) {
            self.value = value
        }

        func beginContentAccess() -> Bool {
            return true
        }

        func endContentAccess() {}

        func discardContentIfPossible() {}

        func isContentDiscarded() -> Bool {
            return false
        }
    }
}
