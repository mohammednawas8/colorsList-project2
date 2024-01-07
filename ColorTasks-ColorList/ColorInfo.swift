//
//  ColorInfo.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

import UIKit

struct ColorInfo {
    let color: UIColor
    let name: String
    let description: String
}

private let sharedDescription = "Cerulean whispers of tranquility across the canvas, evoking a serene sky's embrace. Scarlet bursts like a fervent flame, igniting passion within every stroke. Emerald dances with nature's lushness, a verdant tapestry of life unfurled. Indigo, a mysterious veil, cloaks the night in enigmatic hues, weaving dreams in its velvety depths."
let colorsList = [
    ColorInfo(color: UIColor(red: 30/255, green: 76/255, blue: 99/255, alpha: 1),
              name: "Deep Teal",
              description: "Deep Teal - \(sharedDescription)"),
    ColorInfo(color: UIColor(red: 16/255, green: 45/255, blue: 118/255, alpha: 1),
              name: "Catalina Blue",
              description: "Catalina Blue - \(sharedDescription)"),
    ColorInfo(color: UIColor(red: 24/255, green: 11/255, blue: 79/255, alpha: 1),
              name: "Dark Indigo",
              description: "Dark Indigo - \(sharedDescription)"),
    ColorInfo(color: UIColor(red: 63/255, green: 16/255, blue: 86/255, alpha: 1),
              name: "Ripe Blum",
              description: "Ripe Blum - \(sharedDescription)"),
    ColorInfo(color: UIColor(red: 78/255, green: 23/255, blue: 42/255, alpha: 1),
              name: "Mulberry Wood",
              description: "Mulberry Wood - \(sharedDescription)"),
    ColorInfo(color: UIColor(red: 120/255, green: 31/255, blue: 14/255, alpha: 1),
              name: "Kenyan Copper",
              description: "Kenyan Copper - \(sharedDescription)"),
    ColorInfo(color: UIColor(red: 115/255, green: 48/255, blue: 16/255, alpha: 1),
              name: "Chestunt",
              description: "Chestunt - \(sharedDescription)"),
    ColorInfo(color: UIColor.black,
              name: "Black",
              description: "Black - \(sharedDescription)"),
    ColorInfo(color: UIColor.orange,
              name: "Orange",
              description: "Orange - \(sharedDescription)"),
]
