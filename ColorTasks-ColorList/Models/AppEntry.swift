//
//  AppEntry.swift
//  ColorTasks-ColorList
//
//  Created by mac on 21/01/2024.
//

import Foundation

struct AppEntry {
    @UserDefaultsStorage(key: Constants.APP_ENTRY)
    var value: Bool?
}
