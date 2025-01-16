//
//  RecipeDetailsResponse.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

struct RecipeDetailsResponse: Decodable {
    struct ExtendedIngredient: Decodable {
        struct Measures: Decodable {
            struct TypedMeasure: Decodable {
                let amount: Double
                let unitShort: String
                let unitLong: String
            }
            
            let us: TypedMeasure
            let metric: TypedMeasure
        }
        
        let id: Int
        var image: String // image name without base server url
        let consistency: String
        let name: String
        let nameClean: String
        let original: String
        let originalName: String
        let amount: Double
        let unit: String
        
        let measures: Measures
        let meta: [String]
    }
    
    struct Nutrition: Decodable {
        struct CaloricBreakdown: Decodable {
            let percentProtein: Double
            let percentFat: Double
            let percentCarbs: Double
        }
        struct WeigthPerServing: Decodable {
            let amount: Int
            let unit: String
        }
        struct Nutrient: Decodable {
            let name: String
            let amount: Double
            let unit: String
            let percentOfDailyNeeds: Double
        }
        
        let nutrients: [Nutrient]
        let weightPerServing: WeigthPerServing
        let caloricBreakdown: CaloricBreakdown
    }
    
    struct AnalyzedInstruction: Decodable {
        struct Step: Decodable {
            struct Ingredient: Decodable, Identifiable {
                let id: Int
                let name: String
                let localizedName: String
                let image: String
            }
            
            let number: Int
            let step: String
            let ingredients: [Ingredient]
        }
        
        let name: String
        let steps: [Step]
    }
    
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
    let spoonacularSourceUrl: String
    
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
    
    let extendedIngredients: [ExtendedIngredient]
    let nutrition: Nutrition
    
    let analyzedInstructions: [AnalyzedInstruction]
}
