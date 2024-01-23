//
//  ColorDataManager.swift
//  ColorTasks-ColorList
//
//  Created by mac on 21/01/2024.
//

import Foundation
import CoreData

class ColorDataManager {
    
    private init() {}
    
    static let shared = ColorDataManager()
    
    private struct Constants {
        static let COLORS_MODEL = "Colors"
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.COLORS_MODEL)
        container.loadPersistentStores { NSPersistentStoreDescription, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) -> Bool {
        let context = backgroundContext ?? persistentContainer.viewContext
        guard context.hasChanges else { return false }
        do {
            try context.save()
            return true
        } catch let error as NSError {
            print("Core Data save error: \(error), \(error.userInfo)")
            return false
        }
    }
    
    func saveDefaultColors() {
        let shouldSaveDefaultColors = !(AppEntry.value ?? false)
        if shouldSaveDefaultColors {
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
            AppEntry.value = true
            ColorOrder.order = defaultColors.extractIds()
        }
    }
    
    func getOrderedColorList() -> [Color] {
        let colorOrder = ColorOrder.order ?? []
        let unorderedColors = try? context.fetch(Color.fetchRequest())
        var orderedColors = [Color]()
        for id in colorOrder {
            if let color = unorderedColors?.first(where: { $0.id == id }) {
                orderedColors.append(color)
            }
        }
        return orderedColors
    }
    
    func saveColor(name: String?, description: String?, value: String?) -> Color? {
        let color = Color(context: context)
        color.name = name
        color.colorDescription = description
        color.value = value
        color.id = UUID().uuidString
        _ = saveContext()
        return color
    }
    
    func deleteColors(list colors: [Color]) -> Bool {
        for color in colors {
            context.delete(color)
        }
        return saveContext()
    }
    
}
