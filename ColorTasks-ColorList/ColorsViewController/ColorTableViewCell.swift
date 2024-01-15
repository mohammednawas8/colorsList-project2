//
//  ColorCellTableViewCell.swift
//  ColorTasks-ColorList
//
//  Created by mac on 08/01/2024.
//

import UIKit

// TODO: show the 

class ColorTableViewCell: UITableViewCell {
    
    @IBOutlet var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorLabel.textColor = .white
        // Clearing the default selection gray color
        let view = UIView()
        view.backgroundColor = .clear
        selectedBackgroundView = view

    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // Customize the editing ui for the cell
    }
    
    func set(color: Color){
        if let hexColor = color.value {
            colorLabel.text = color.name
            backgroundColor = UIColor(hex: hexColor)
        }
    }
    
}
