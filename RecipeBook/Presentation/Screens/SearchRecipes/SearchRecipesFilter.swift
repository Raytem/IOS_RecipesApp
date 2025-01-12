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
    var cuisines: Set<Cuisine>
    var diets: Set<Diet>
    var mealTypes: Set<MealType>
    var maxReadyTime: Double?
    
    init(
        cardViewType: RecipeCardViewType = .grid,
        query: String? = nil,
        cuisines: Set<Cuisine> = Set(),
        diets: Set<Diet> = Set(),
        mealTypes: Set<MealType> = Set(),
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
