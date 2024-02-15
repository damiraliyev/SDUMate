//
//  UserDefault.swift
//  BePRO
//
//  Created by Sanzhar Dauylov on 25.01.2024.
//

import Foundation

@propertyWrapper
public struct UserDefault<Value> {
    private let get: () -> Value
    private let set: (Value) -> Void

    public var wrappedValue: Value {
        get { get() }
        nonmutating set { set(newValue) }
    }
}

public extension UserDefault {
    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == Bool {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == Int {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == Double {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == String {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == URL {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == Data {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == Date {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value == [String: String] {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    private init(defaultValue: Value, key: String, store: UserDefaults) {
        get = {
            let value = store.value(forKey: key) as? Value
            return value ?? defaultValue
        }

        set = { newValue in
            store.set(newValue, forKey: key)
        }
    }
}

public extension UserDefault where Value: ExpressibleByNilLiteral {
    init(_ key: String, store: UserDefaults = .standard) where Value == Bool? {
        self.init(wrappedType: Bool.self, key: key, store: store)
    }

    init(_ key: String, store: UserDefaults = .standard) where Value == Int? {
        self.init(wrappedType: Int.self, key: key, store: store)
    }

    init(_ key: String, store: UserDefaults = .standard) where Value == Double? {
        self.init(wrappedType: Double.self, key: key, store: store)
    }

    init(_ key: String, store: UserDefaults = .standard) where Value == String? {
        self.init(wrappedType: String.self, key: key, store: store)
    }

    init(_ key: String, store: UserDefaults = .standard) where Value == URL? {
        self.init(wrappedType: URL.self, key: key, store: store)
    }

    init(_ key: String, store: UserDefaults = .standard) where Value == Data? {
        self.init(wrappedType: Data.self, key: key, store: store)
    }

    init(_ key: String, store: UserDefaults = .standard) where Value == Date? {
        self.init(wrappedType: Date.self, key: key, store: store)
    }

    init(_ key: String, store: UserDefaults = .standard) where Value == [String: String]? {
        self.init(wrappedType: [String: String].self, key: key, store: store)
    }

    private init<T>(wrappedType: T.Type, key: String, store: UserDefaults) {
        get = {
            let value = store.value(forKey: key) as? Value
            return value ?? nil
        }

        set = { newValue in
            let newValue = newValue as? Optional<T>

            if let newValue {
                store.set(newValue, forKey: key)
            } else {
                store.removeObject(forKey: key)
            }
        }
    }
}

public extension UserDefault where Value: RawRepresentable {
    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value.RawValue == String {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults = .standard) where Value.RawValue == Int {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    private init(defaultValue: Value, key: String, store: UserDefaults) {
        get = {
            var value: Value?

            if let rawValue = store.value(forKey: key) as? Value.RawValue {
                value = Value(rawValue: rawValue)
            }

            return value ?? defaultValue
        }

        set = { newValue in
            let value = newValue.rawValue
            store.set(value, forKey: key)
        }
    }
}

public extension UserDefault {
    init<R>(_ key: String, store: UserDefaults = .standard) where Value == R?, R: RawRepresentable, R.RawValue == Int {
        self.init(key: key, store: store)
    }

    init<R>(_ key: String, store: UserDefaults = .standard) where Value == R?, R: RawRepresentable, R.RawValue == String {
        self.init(key: key, store: store)
    }

    private init<R>(key: String, store: UserDefaults) where Value == R?, R: RawRepresentable {
        get = {
            if let rawValue = store.value(forKey: key) as? R.RawValue {
                return R(rawValue: rawValue)
            } else {
                return nil
            }
        }

        set = { newValue in
            let newValue = newValue as Optional<R>

            if let newValue {
                store.set(newValue.rawValue, forKey: key)
            } else {
                store.removeObject(forKey: key)
            }
        }
    }
}

public extension UserDefault where Value: Codable {
    init(wrappedValue: Value,_ key: String, store: UserDefaults = .standard) where Value: Codable {
        self.init(defaultValue: wrappedValue, key: key, store: store)
    }

    private init(defaultValue: Value, key: String, store: UserDefaults) {
        get = {
            if let data = store.value(forKey: key) as? Data,
               let decodedValue = try? JSONDecoder().decode(Value.self, from: data) {
                return decodedValue
            } else {
                return defaultValue
            }
        }

        set = { newValue in
            if let encodedData = try? JSONEncoder().encode(newValue) {
                store.set(encodedData, forKey: key)
            }
        }
    }
}

public extension UserDefault {
    init<R: Codable>(_ key: String, store: UserDefaults = .standard) where Value == R?, R: Codable {
        self.init(key: key, store: store)
    }

    private init<R: Codable>(key: String, store: UserDefaults) where Value == R?, R: Codable {
        get = {
            if let data = store.value(forKey: key) as? Data,
               let decodedValue = try? JSONDecoder().decode(R.self, from: data) {
                return decodedValue
            } else {
                return nil
            }
        }

        set = { newValue in
            let newValue = newValue as Optional<R>

            if let newValue {
                if let encodedData = try? JSONEncoder().encode(newValue) {
                    store.set(encodedData, forKey: key)
                }
            } else {
                store.removeObject(forKey: key)
            }
        }
    }
}
