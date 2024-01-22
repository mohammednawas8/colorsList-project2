//
//  UserDefaultsStorage.swift
//  ColorTasks-ColorList
//
//  Created by mac on 21/01/2024.
//

import Foundation

enum UserDefaultsKey: String {
    case AppEntry
    case ColorOrder
}

struct ColorOrder {
    @UserDefaultsStorage(key: .ColorOrder)
    var order: [String]?
}

struct AppEntry {
    @UserDefaultsStorage(key: .AppEntry)
    var value: Bool?
}


@propertyWrapper
class UserDefaultsStorage<T: Codable> {
    private var storage: UserDefaults
    private var key: UserDefaultsKey
    
    init(storage: UserDefaults = .standard, key: UserDefaultsKey) {
        self.storage = storage
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            if let data = storage.data(forKey: key.rawValue) {
                let value = try? JSONDecoder().decode(T.self, from: data)
                return value
            }
            return nil
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key.rawValue)
        }
    }
}
