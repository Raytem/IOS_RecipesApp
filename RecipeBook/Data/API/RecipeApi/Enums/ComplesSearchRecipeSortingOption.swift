//
//  ComplesSearchSortingOptions.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//


enum ComplesSearchRecipeSortingOption: String, CaseIterable {
    case popularity = "popularity"
    case healthiness = "healthiness"
    case time = "time"
    case calories = "calories"
    case maxUsedIngredients = "max-used-ingredients"
}
