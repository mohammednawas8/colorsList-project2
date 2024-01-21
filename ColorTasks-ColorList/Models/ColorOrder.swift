//
//  ColorOrder.swift
//  ColorTasks-ColorList
//
//  Created by mac on 21/01/2024.
//

import Foundation

struct ColorOrder {
    @UserDefaultsStorage(key: Constants.COLOR_ORDER)
    var order: [String]?
}
