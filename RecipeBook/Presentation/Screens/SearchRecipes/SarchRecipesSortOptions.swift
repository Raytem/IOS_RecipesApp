//
//  SarchRecipesSortOptions.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import Foundation

enum SearchRecipesSortOption: CaseIterable, DisplayNamable {
    case popular
    case quickToCook
    case lessIngridients
    case moreIngridients
    case healthy
    case harmful
    case theLeastCaloric
    case theMostHighCalorie
    
    var displayName: String {
        switch self {
        case .popular: String(localized: "Popular", table: "RecipeSortingOptions")
        case .quickToCook: String(localized: "Qick to cook", table: "RecipeSortingOptions")
        case .lessIngridients: String(localized: "Less ingridients", table: "RecipeSortingOptions")
        case .moreIngridients: String(localized: "More ingridients", table: "RecipeSortingOptions")
        case .healthy: String(localized: "Healthy", table: "RecipeSortingOptions")
        case .harmful: String(localized: "Harmful", table: "RecipeSortingOptions")
        case .theLeastCaloric: String(localized: "The least caloric", table: "RecipeSortingOptions")
        case .theMostHighCalorie: String(localized: "The most high calorie", table: "RecipeSortingOptions")
        }
    }
}
