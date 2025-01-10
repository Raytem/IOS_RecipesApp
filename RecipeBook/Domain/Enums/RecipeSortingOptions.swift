//
//  RecipeSortingOptions.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

enum RecipeSortingOptions: String, CaseIterable {
    case popularity = "popularity"
    case healthiness = "healthiness"
    case time = "time"
    case maxUsedIngredients = "max-used-ingredients"
    case minMissingIngredients = "min-missing-ingredients"
    case calories = "calories"
}



