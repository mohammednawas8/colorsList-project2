//
//  Color+CoreDataProperties.swift
//  ColorTasks-ColorList
//
//  Created by mac on 16/01/2024.
//
//

import Foundation
import CoreData


extension Color {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Color> {
        return NSFetchRequest<Color>(entityName: "Color")
    }

    @NSManaged public var colorDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var value: String?
    @NSManaged public var id: String?

}

extension Color : Identifiable {

}
