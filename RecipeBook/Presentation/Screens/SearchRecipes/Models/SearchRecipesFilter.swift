//
//  ProductsFilterModel.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import Foundation

@Observable
class SearchRecipesFilter {
    var cardViewType: RecipeCardViewType
    var query: String?
    var cuisines: [Cuisine]?
    var diets: [Diet]?
    var mealTypes: [MealType]?
    var maxReadyTime: Double?
    
    init(
        cardViewType: RecipeCardViewType,
        query: String? = nil,
        cuisines: [Cuisine]? = nil,
        diets: [Diet]? = nil,
        mealTypes: [MealType]? = nil,
        maxReadyTime: Double? = nil
    ) {
        self.cardViewType = cardViewType
        self.query = query
        self.cuisines = cuisines
        self.diets = diets
        self.mealTypes = mealTypes
        self.maxReadyTime = maxReadyTime
    }
}
