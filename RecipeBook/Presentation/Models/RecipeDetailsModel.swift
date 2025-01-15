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
        var name: String
        var image: URL?
        var consistency: String
        var amount: Double
        var unit: String
    }
    
    var id: Int
    var title: String
    var image: URL?
    var readyInMinutes: Int
    var aggregateLikes: Int
    var diets: [Diet]
    var cuisines: [Cuisine]
    var dishTypes: [MealType]
    var summary: String
    var healthScore: Int
    var servings: Int
    var extendedIngredients: [ExtendedIngredient]
}
