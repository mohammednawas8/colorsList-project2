//
//  BaseUIViewController.swift
//  ColorTasks-ColorList
//
//  Created by mac on 22/01/2024.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    func presentErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alertController, animated: true)
    }
}
