//
//  RecipeCardSettings.swift
//  RecipeBook
//
//  Created by Daniil on 10.01.25.
//

import Foundation
import SwiftUI

struct RecipeCardSettings {
    var imageHeight: CGFloat?
    var imageWidth: CGFloat?
    var cardHeight: CGFloat?
    var buttonAlignment: Alignment
    var buttonFullWidth: Bool
    var isStackVertical: Bool
    
    static let recipeCardSettings: [RecipeCardViewType: RecipeCardSettings] = [
        .grid: .init(imageHeight: 200, imageWidth: nil, cardHeight: 370, buttonAlignment: .center, buttonFullWidth: true, isStackVertical: true),
        .list: .init(imageHeight: 180, imageWidth: 160, cardHeight: 180, buttonAlignment: .leading, buttonFullWidth: false, isStackVertical: false),
        .single: .init(imageHeight: 400, imageWidth: nil, cardHeight: 560, buttonAlignment: .leading, buttonFullWidth: false, isStackVertical: true)
    ]
        
    static func get(for viewType: RecipeCardViewType) -> RecipeCardSettings {
        return recipeCardSettings[viewType] ?? recipeCardSettings[.grid]!
    }
}
