//
//  ColorDescriptionView.swift
//  ColorTasks-ColorList
//
//  Created by mac on 09/01/2024.
//

import UIKit

@IBDesignable
class ColorDescriptionView : UIView {
    
    @IBOutlet private var view: UIView!
    @IBOutlet private var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) { // Called to render the view on the Interface Builder
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        guard let fileName = #file.getFileNamePath() else { return }
        view = loadViewFromNib(nibName: fileName)
        view.frame = self.bounds // Matching the loaded view from the nib with the ColorDescriptionView
        addSubview(view)
    }
    
    func setBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
    func setDescription(description: String) {
        descriptionLabel.text = description
    }
}
