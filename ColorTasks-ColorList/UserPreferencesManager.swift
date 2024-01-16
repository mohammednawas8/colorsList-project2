//
//  UserPreferencesManager.swift
//  ColorTasks-ColorList
//
//  Created by mac on 16/01/2024.
//

import Foundation

protocol UserPreferencesManager {
    func saveAppEntry()
    func readAppEntry() -> Bool
    func saveColorOrder(colors: [Color])
    func readColorOrder() -> [String]?
}

class UserPreferencesManagerImpl: UserPreferencesManager {
    
    private static var instance = UserPreferencesManagerImpl()
    var defaults = UserDefaults.standard
    
    private struct Constants {
        static let APP_ENTRY = "AppEntry"
        static let COLOR_RANKS = "ColorRanks"
    }
    
    private init() {}
    
    static func getInstance() -> UserPreferencesManager {
        return instance
    }
    
    func saveAppEntry() {
        defaults.setValue(true, forKey: Constants.APP_ENTRY)
    }
    
    func readAppEntry() -> Bool {
        return defaults.bool(forKey: Constants.APP_ENTRY)
    }
    
    func saveColorOrder(colors: [Color]) {
        let colorOrder = colors.compactMap { $0.id }
        defaults.set(colorOrder, forKey: Constants.COLOR_RANKS)
    }
    
    func readColorOrder() -> [String]? {
        return defaults.array(forKey: Constants.COLOR_RANKS) as? [String]
    }
}
