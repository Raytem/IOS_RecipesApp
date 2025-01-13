//
//  ProductsFilterModel.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import Foundation

struct SearchRecipesFilter {
    var cuisines: Set<Cuisine>
    var diets: Set<Diet>
    var mealTypes: Set<MealType>
    var maxReadyTime: Int?
    
    init(
        cardViewType: RecipeCardViewType = .grid,
        cuisines: Set<Cuisine> = Set(),
        diets: Set<Diet> = Set(),
        mealTypes: Set<MealType> = Set(),
        maxReadyTime: Int? = nil
    ) {
        self.cuisines = cuisines
        self.diets = diets
        self.mealTypes = mealTypes
        self.maxReadyTime = maxReadyTime
    }
}
