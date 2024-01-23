//
//  Color+CoreDataClass.swift
//  ColorTasks-ColorList
//
//  Created by mac on 15/01/2024.
//
//

import UIKit
import CoreData

@objc(Color)
public class Color: NSManagedObject {
    
    private static let sharedDescription = "Cerulean whispers of tranquility across the canvas, evoking a serene sky's embrace. Scarlet bursts like a fervent flame, igniting passion within every stroke. Emerald dances with nature's lushness, a verdant tapestry of life unfurled. Indigo, a mysterious veil, cloaks the night in enigmatic hues, weaving dreams in its velvety depths."
    
    static func getDefaultColors() -> [(value: String, name: String, description:String)] {
        return [
            getDefaultColor(red: 30, green: 76, blue: 99, name: "Deep Teal"),
            getDefaultColor(red: 16, green: 45, blue: 118, name: "Catalina Blue"),
            getDefaultColor(red: 24, green: 11, blue: 79, name: "Dark Indigo"),
            getDefaultColor(red: 63, green: 16, blue: 86, name: "Ripe Blum"),
            getDefaultColor(red: 78, green: 23, blue: 42, name: "Mulberry Wood"),
            getDefaultColor(red: 120, green: 31, blue: 14, name: "Kenyan Copper"),
            getDefaultColor(red: 115, green: 48, blue: 16, name: "Chestunt"),
            getDefaultColor(red: 0, green: 0, blue: 0, name: "Black"),
            getDefaultColor(red: 255, green: 119, blue: 0, name: "Ornage"),
        ]
    }
    
    private static func getDefaultColor(red: CGFloat, green: CGFloat, blue: CGFloat, name: String) -> (value: String, name: String, description:String) {
        let value = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1).toHexString()
        let description = "\(name) description - \(sharedDescription)"
        return (value, name, description)
    }
}
