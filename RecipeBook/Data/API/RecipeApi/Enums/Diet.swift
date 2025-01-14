//
//  Diet.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

enum Diet: String, CaseIterable, Codable, DisplayNamable {
    case glutenFree = "gluten free"
    case dairyFree = "dairy free"
    case ketogenic = "ketogenic"
    case vegetarian = "vegetarian"
    case lactoVegetarian = "lacto vegetarian"
    case ovoVegetarian = "ovo vegetarian"
    case lactoOvoVegeterian = "lacto ovo vegetarian"
    case vegan = "vegan"
    case pescetarian = "pescetarian"
    case paleo = "paleo"
    case primal = "primal"
    case lowFODMAP = "low foodmap"
    case whole30 = "whole 30"
    
    var displayName: String {
        switch self {
        case .dairyFree: String(localized: "Dairy free", table: "Diets")
        case .glutenFree: String(localized: "Gluten free", table: "Diets")
        case .ketogenic: String(localized: "Ketogenic", table: "Diets")
        case .vegetarian: String(localized: "Vegetarian", table: "Diets")
        case .lactoVegetarian: String(localized: "Lacto-vegetarian", table: "Diets")
        case .ovoVegetarian: String(localized: "Ovo-vegetarian", table: "Diets")
        case .lactoOvoVegeterian: String(localized: "Lacto-ovo-vegetarian", table: "Diets")
        case .vegan: String(localized: "Vegan", table: "Diets")
        case .pescetarian: String(localized: "Pescetarian", table: "Diets")
        case .paleo: String(localized: "Paleo", table: "Diets")
        case .primal: String(localized: "Primal", table: "Diets")
        case .lowFODMAP: String(localized: "Low FODMAP", table: "Diets")
        case .whole30: String(localized: "Whole30", table: "Diets")
        }
    }
}
