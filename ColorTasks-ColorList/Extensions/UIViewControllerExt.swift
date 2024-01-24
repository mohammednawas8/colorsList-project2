//
//  UIViewControllerExt.swift
//  ColorTasks-ColorList
//
//  Created by mac on 24/01/2024.
//

import UIKit

extension UIViewController {
    
    func instantiateViewController<T: UIViewController>(identifier: String) -> T? {
        return storyboard?.instantiateViewController(withIdentifier: identifier) as? T
    }
}
