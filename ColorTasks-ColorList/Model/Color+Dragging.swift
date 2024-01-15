//
//  Color+Dragging.swift
//  ColorTasks-ColorList
//
//  Created by mac on 14/01/2024.
//

import UIKit

extension Color {
    static func dragItem(for indexPath: IndexPath, colors: [Color]) -> [UIDragItem] {
        let draggedColor = colors[indexPath.row]
        let data = try? NSKeyedArchiver.archivedData(withRootObject: draggedColor, requiringSecureCoding: false)
        if let data {
            let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: "com.loc.colorinfo")
            let dragItem = UIDragItem(itemProvider: itemProvider)
            return [dragItem]
        }
        return []
    }
}
