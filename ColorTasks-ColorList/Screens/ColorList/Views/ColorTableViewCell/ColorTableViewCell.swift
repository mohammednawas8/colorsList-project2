//
//  ColorCellTableViewCell.swift
//  ColorTasks-ColorList
//
//  Created by mac on 08/01/2024.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    @IBOutlet private var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.textColor = .white
        // Clearing the default gray color selection
        let view = UIView()
        view.backgroundColor = .clear
        selectedBackgroundView = view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        changeReorderColor()
    }
    
    func configureCell(model: Color) {
        if let hexColor = model.value {
            colorLabel.text = model.name
            backgroundColor = UIColor(hex: hexColor)
        }
    }
    
    func changeReorderColor() {
        for subview in subviews {
            if let reorderControl = subview.subviews.first(where: { $0 is UIImageView }) as? UIImageView {
                reorderControl.image = reorderControl.image?.withTintColor(.white)
            }
        }
    }
}
