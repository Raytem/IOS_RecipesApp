//
//  Item.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
