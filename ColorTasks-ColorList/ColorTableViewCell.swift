//
//  ColorCellTableViewCell.swift
//  ColorTasks-ColorList
//
//  Created by mac on 08/01/2024.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        colorLabel.textColor = .white
    }
    
    func set(color: ColorInfo){
        colorLabel.text = color.name
        backgroundColor = color.value
    }
}
