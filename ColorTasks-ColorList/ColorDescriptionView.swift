//
//  ColorDescriptionView.swift
//  ColorTasks-ColorList
//
//  Created by mac on 09/01/2024.
//

import UIKit

@IBDesignable
class ColorDescriptionView : UIView {
    @IBOutlet var view: UIView!
    @IBOutlet var descriptionLabel: UILabel!
    private struct Constants {
        static let NIB_NAME = "ColorDescriptionView"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        view = loadViewFromNib(nibName: Constants.NIB_NAME)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = self.bounds
        addSubview(view)
    }
    
    func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self)[0] as! UIView
        return view
    }
    
    func setBackgroundColor(color: UIColor){
        view.backgroundColor = color
    }
    func setDescription(description: String){
        descriptionLabel.text = description
    }
}
