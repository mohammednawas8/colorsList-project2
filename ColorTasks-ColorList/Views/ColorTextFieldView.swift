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
    
    private var textFieldHeight: CGFloat = CGFloat(0)

    @IBInspectable var hint: String = "Label" {
        didSet {
            hintLabel.text = hint
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    @IBInspectable var circular: Bool = true {
        didSet {
            let cornerRadius = circular ? textFieldHeight/2 : 30
            textField.layer.cornerRadius = CGFloat(cornerRadius)
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
        view = loadTextFieldFromNib(nibName: "ColorTextField")
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = self.bounds
        addSubview(view)
        setupTextField()
    }
    
    func loadTextFieldFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let textField = nib.instantiate(withOwner: self)[0] as! UIView
        return textField
    }
    
    func setupTextField() {
        let viewHeight = view.frame.height
        textFieldHeight = viewHeight - 10 - hintLabel.frame.height
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.borderStyle = .none
        setHeight()
        setTextPadding()
    }
    
    func setHeight() {
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
    
    func setTextPadding() {
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textFieldHeight))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: -20, height: textFieldHeight))
        textField.rightViewMode = .always
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 50)
    }
}
