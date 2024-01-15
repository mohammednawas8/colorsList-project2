//
//  ColorsViewController+Drag.swift
//  ColorTasks-ColorList
//
//  Created by mac on 10/01/2024.
//

import UIKit

extension ColorsViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return Color.dragItem(for: indexPath, colors: colorsList)
    }
}
