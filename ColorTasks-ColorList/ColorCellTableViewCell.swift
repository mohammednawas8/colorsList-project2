//
//  ColorCellTableViewCell.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

import UIKit

class ColorCellTableViewCell: UITableViewCell {
    
    let colorLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureColorLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureColorLabel(){
        addSubview(colorLabel)
        colorLabel.textColor = .white
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colorLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func set(colorInfo: ColorInfo){
        self.backgroundColor = colorInfo.color
        colorLabel.text = colorInfo.name
    }

}
