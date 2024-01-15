//
//  AddColorViewController+ColorPickerDelegate.swift
//  ColorTasks-ColorList
//
//  Created by mac on 13/01/2024.
//

import UIKit

extension AddColorViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        selectedColor = color
    }
}
