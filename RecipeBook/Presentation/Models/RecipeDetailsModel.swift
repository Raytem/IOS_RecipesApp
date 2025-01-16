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
    
    struct CookingStep {
        var number: Int
        var desctipion: String
    }
    
    struct Nutrition {
        struct Nutrient {
            let name: String
            let amount: Double
            let unit: String
        }
        
        struct WeigthPerServing: Decodable {
            let amount: Int
            let unit: String
        }
        
        let nutrients: [Nutrient]
        let weightPerServing: WeigthPerServing
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
    var sourceUrl: String
    
    var nutrition: Nutrition
    
    var extendedIngredients: [ExtendedIngredient]
    var cookingSteps: [CookingStep]
}
