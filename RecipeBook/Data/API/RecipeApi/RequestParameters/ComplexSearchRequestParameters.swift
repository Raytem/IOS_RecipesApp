//
//  ComplexSearchRequestParameters.swift
//  RecipeBook
//
//  Created by Daniil on 14.01.25.
//

struct ComplexSearchRequestParameters {
    var pagination: PaginationParameters? = nil
    var sort: SortParameters<ComplesSearchRecipeSortingOption>? = nil
    
    var query: String? = nil
    var cuisines: Set<Cuisine>? = nil
    var diets: Set<Diet>? = nil
    var mealTypes: Set<MealType>? = nil
    var maxReadyTime: Int? = nil
}
