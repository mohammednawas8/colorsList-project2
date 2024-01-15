//
//  UIHelper.swift
//  ColorTasks-ColorList
//
//  Created by mac on 14/01/2024.
//

import UIKit

func createAlertController(title: String? = "Error", message: String) -> UIAlertController{
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
    return alertController
}
