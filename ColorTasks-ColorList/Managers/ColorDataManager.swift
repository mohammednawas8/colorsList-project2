//
//  ColorDataManager.swift
//  ColorTasks-ColorList
//
//  Created by mac on 21/01/2024.
//

import Foundation
import CoreData

class ColorDataManager {
    
    private var colorOrder: ColorOrder
    private var appEntry: AppEntry
    private var persistentContainer: NSPersistentContainer
    
    init(colorOrder: ColorOrder = ColorOrder(), appEntry: AppEntry = AppEntry() ,persistentContainer: NSPersistentContainer) {
        self.colorOrder = colorOrder
        self.appEntry = appEntry
        self.persistentContainer = persistentContainer
    }
    
    func saveDefaultColors() {
        let shouldSaveDefaultColors = !(appEntry.value ?? false)
        if shouldSaveDefaultColors {
            let context = persistentContainer.viewContext
            var defaultColors = [Color]()
            for colorTuple in Color.getDefaultColors() {
                let color = Color(context: context)
                color.value = colorTuple.value
                color.colorDescription = colorTuple.description
                color.name = colorTuple.name
                color.id = UUID().uuidString
                defaultColors.append(color)
                try? context.save()
            }
            appEntry.value = true
            colorOrder.order = defaultColors.extractIds()
        }
    }
}
