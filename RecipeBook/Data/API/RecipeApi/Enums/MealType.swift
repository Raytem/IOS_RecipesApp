//
//  MealType.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

enum MealType: String, CaseIterable, Codable, DisplayNamable {
    case mainCourse = "main course"
    case mainDish = "main dish"
    case sideDish = "side dish"
    case dessert = "dessert"
    case appetizer = "appetizer"
    case salad = "salad"
    case bread = "bread"
    case breakfast = "breakfast"
    case soup = "soup"
    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    case fingerfood = "fingerfood"
    case snack = "snack"
    case drink = "drink"
    case lunch = "lunch"
    case dinner = "dinner"
    
    var displayName: String {
        switch self {
        case .mainCourse: String(localized: "Main course", table: "MealTypes")
        case .mainDish: String(localized: "Main dish", table: "MealTypes")
        case .sideDish: String(localized: "Side dish", table: "MealTypes")
        case .dessert: String(localized: "Dessert", table: "MealTypes")
        case .appetizer: String(localized: "Appetizer", table: "MealTypes")
        case .salad: String(localized: "Salad", table: "MealTypes")
        case .bread: String(localized: "Bread", table: "MealTypes")
        case .breakfast: String(localized: "Breakfast", table: "MealTypes")
        case .soup: String(localized: "Soup", table: "MealTypes")
        case .beverage: String(localized: "Beverage", table: "MealTypes")
        case .sauce: String(localized: "Sauce", table: "MealTypes")
        case .marinade: String(localized: "Marinade", table: "MealTypes")
        case .fingerfood: String(localized: "Finger food", table: "MealTypes")
        case .snack: String(localized: "Snack", table: "MealTypes")
        case .drink: String(localized: "Drink", table: "MealTypes")
        case .lunch: String(localized: "Lunch", table: "MealTypes")
        case .dinner: String(localized: "Dinner", table: "MealTypes")
        }
    }
}
