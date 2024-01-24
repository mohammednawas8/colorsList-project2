//
//  ViewExt.swift
//  ColorTasks-ColorList
//
//  Created by mac on 22/01/2024.
//

import UIKit

extension UIView {
    
    var viewName: String {
        return String(describing: type(of: self))
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: viewName, bundle: bundle)
        let view = nib.instantiate(withOwner: self)[0] as? UIView
        return view ?? UIView()
    }
}
