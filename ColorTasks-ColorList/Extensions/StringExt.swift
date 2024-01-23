//
//  StringExt.swift
//  ColorTasks-ColorList
//
//  Created by mac on 22/01/2024.
//

import Foundation

extension String {
    func getFileNamePath() -> String? {
        let lastPathComponent = URL(filePath: self).lastPathComponent
        return (lastPathComponent as NSString).deletingPathExtension
    }
}
