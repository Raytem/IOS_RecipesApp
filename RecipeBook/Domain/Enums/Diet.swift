//
//  Diet.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

enum Diet: String, CaseIterable, Codable {
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
}
