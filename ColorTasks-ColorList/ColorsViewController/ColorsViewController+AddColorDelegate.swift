//
//  ColorsViewController+AddColorDelegate.swift
//  ColorTasks-ColorList
//
//  Created by mac on 14/01/2024.
//

import Foundation

extension ColorsViewController: AddColorDelegate {
    func didAddNewColor(color: Color) {
        colorList.append(color)
    }
}
