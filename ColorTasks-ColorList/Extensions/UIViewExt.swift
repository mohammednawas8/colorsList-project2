//
//  ViewExt.swift
//  ColorTasks-ColorList
//
//  Created by mac on 22/01/2024.
//

import UIKit

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self)[0] as? UIView
        return view ?? UIView()
    }
}
