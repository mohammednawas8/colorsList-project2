//
//  UserDefaultsStorage.swift
//  ColorTasks-ColorList
//
//  Created by mac on 21/01/2024.
//

import Foundation

@propertyWrapper
class UserDefaultsStorage<T: Codable> {
    private var storage: UserDefaults
    private var key: String
    
    init(storage: UserDefaults = .standard, key: String) {
        self.storage = storage
        self.key = key
    }
    
    var wrappedValue: T? {
        get {
            if let data = storage.data(forKey: key) {
                let value = try? JSONDecoder().decode(T.self, from: data)
                return value
            }
            return nil
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key)
        }
    }
}
