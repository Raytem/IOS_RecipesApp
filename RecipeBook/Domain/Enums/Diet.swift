//
//  Diet.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

enum Diet: String, CaseIterable, Codable, DisplayNamable {
    case glutenFree = "Gluten Free"
    case ketogenic = "Ketogenic"
    case vegetarian = "Vegetarian"
    case lactoVegetarian = "Lacto-Vegetarian"
    case ovoVegetarian = "Ovo-Vegetarian"
    case vegan = "Vegan"
    case pescetarian = "Pescetarian"
    case paleo = "Paleo"
    case primal = "Primal"
    case lowFODMAP = "Low FODMAP"
    case whole30 = "Whole30"
    
    var displayName: String {
        switch self {
        case .glutenFree: String(localized: "Gluten free", table: "Diets")
        case .ketogenic: String(localized: "Ketogenic", table: "Diets")
        case .vegetarian: String(localized: "Vegetarian", table: "Diets")
        case .lactoVegetarian: String(localized: "Lacto-vegetarian", table: "Diets")
        case .ovoVegetarian: String(localized: "Ovo-vegetarian", table: "Diets")
        case .vegan: String(localized: "Vegan", table: "Diets")
        case .pescetarian: String(localized: "Pescetarian", table: "Diets")
        case .paleo: String(localized: "Paleo", table: "Diets")
        case .primal: String(localized: "Primal", table: "Diets")
        case .lowFODMAP: String(localized: "Low FODMAP", table: "Diets")
        case .whole30: String(localized: "Whole30", table: "Diets")
        }
    }
}
