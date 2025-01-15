//
//  RecipeDto.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

struct ComplexSearchRecipeResponse: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String
    let summary: String
    let readyInMinutes: Int
    let preparationMinutes: Int?
    let cookingMinutes: Int?
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let sourceUrl: String
    let aggregateLikes: Int
    let healthScore: Int
    
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let pricePerServing: Double
    let servings: Int
}
