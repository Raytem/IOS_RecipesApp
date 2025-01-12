//
//  RecipeCardSettings.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import Foundation
import SwiftUI

struct RecipeCardSettings {
    var imageHeight: CGFloat
    var imageWidth: CGFloat
    var cardHeight: CGFloat
    var buttonAlignment: Alignment
    var isStackVertical: Bool
    
    static let recipeCardSettings: [RecipeCardViewType: RecipeCardSettings] = [
        .grid: .init(imageHeight: 180, imageWidth: .infinity, cardHeight: 340, buttonAlignment: .center, isStackVertical: true),
        .list: .init(imageHeight: 180, imageWidth: 160, cardHeight: 180, buttonAlignment: .leading, isStackVertical: false),
        .single: .init(imageHeight: 400, imageWidth: .infinity, cardHeight: 560, buttonAlignment: .leading, isStackVertical: true)
    ]
        
    static func get(for viewType: RecipeCardViewType) -> RecipeCardSettings {
        return recipeCardSettings[viewType] ?? recipeCardSettings[.grid]!
    }
}
