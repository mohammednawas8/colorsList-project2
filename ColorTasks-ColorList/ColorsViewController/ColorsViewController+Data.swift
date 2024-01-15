//
//  ColorsViewController+Data.swift
//  ColorTasks-ColorList
//
//  Created by mac on 10/01/2024.
//

import UIKit

extension ColorsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER, for: indexPath) as! ColorTableViewCell
        cell.set(color: colorsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isInEditMode {
            selectedColor = colorsList[indexPath.row]
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isInEditMode
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    private func moveItem(from sourceIndex: Int, to destinationIndex: Int){
        guard sourceIndex != destinationIndex else { return }
        let movedColor = colorsList.remove(at: sourceIndex)
        colorsList.insert(movedColor, at: destinationIndex)
    }
    
}
