//
//  AddColorDelegate.swift
//  ColorTasks-ColorList
//
//  Created by mac on 14/01/2024.
//

import Foundation

protocol AddColorDelegate: AnyObject {
    func didAddNewColor(color: Color)
}
