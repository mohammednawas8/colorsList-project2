//
//  ColorTextField.swift
//  ColorTasks-ColorList
//
//  Created by mac on 11/01/2024.
//

import UIKit

@IBDesignable
class ColorTextFieldView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var hintLabel: UILabel!
    
    @IBInspectable var textFieldTitle: String = "" {
        didSet {
            hintLabel.text = textFieldTitle
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    @IBInspectable var cornerRadius: Bool = true {
        didSet {
            setCornerRadius()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        view = loadViewFromNib()
        view.frame = self.bounds
        addSubview(view)
        setupTextField()
    }
    
    func setupTextField() {
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .none
        setCornerRadius()
        setTextPadding()
    }
    
    private func setCornerRadius() {
        let textFieldHeight = textField.bounds.height
        let cornerRadius = cornerRadius ? textFieldHeight/1.5 : 0
        textField.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func setTextPadding() {
        // I Couldn't find Content Inset for textField it is only availabe for textView
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: -20, height: 0))
        textField.rightViewMode = .always
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 50)
    }
}
