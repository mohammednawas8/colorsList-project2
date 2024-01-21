//
//  ColorExt.swift
//  ColorTasks-ColorList
//
//  Created by mac on 21/01/2024.
//

import Foundation

extension [Color] {
    func extractIds() -> [String] {
        return self.compactMap { $0.id }
    }
}
