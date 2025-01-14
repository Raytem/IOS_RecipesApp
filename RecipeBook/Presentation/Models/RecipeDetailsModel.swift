//
//  RecipeDetailsModel.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import Foundation
import SwiftUI

struct RecipeDetailsModel: Identifiable {
    struct ExtendedIngredient: Identifiable {
        var id: Int
        let name: String
        var image: URL?
        let consistency: String
        let amount: Double
        let unit: String
    }
    
    var id: Int
    var title: String
    var image: URL?
    var readyInMinutes: Int
    var aggregateLikes: Int
    var diets: [Diet]
    let cuisines: [Cuisine]
    let dishTypes: [MealType]
    let summary: String
    let healthScore: Int
    var extendedIngredients: [ExtendedIngredient]
}
