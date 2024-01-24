//
//  UINavigationBarExt.swift
//  ColorTasks-ColorList
//
//  Created by mac on 24/01/2024.
//

import UIKit

extension UINavigationBar {
    
    func addBottomBoder(color: UIColor = .veryLightGray, height: CGFloat) {
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = color
        bottomBorder.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        addSubview(bottomBorder)
    }
}
