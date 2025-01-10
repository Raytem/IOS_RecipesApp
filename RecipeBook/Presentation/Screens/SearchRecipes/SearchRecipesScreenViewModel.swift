//
//  SearchRecipesScreenViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import SwiftUI

@Observable
class SearchRecipesScreenViewModel {
    public var recipesModels: [RecipeModel]
    
    public var isFiltersSheetShowing = false
    public var isSortingOptionsSheetShowing = false

    public var filters = SearchRecipesFilter(cardViewType: .grid)
    
    init (recipesModels: [RecipeModel]) {
        self.recipesModels = recipesModels
    }
    
    public var sortingOptions = [
        NSLocalizedString("RecipeSearchSortingOption.Popular", comment: ""),
        NSLocalizedString("RecipeSearchSortingOption.QickToCook", comment: ""),
        NSLocalizedString("RecipeSearchSortingOption.FiewerIngridients", comment: ""),
        NSLocalizedString("RecipeSearchSortingOption.MoreIngridients", comment: ""),
        NSLocalizedString("RecipeSearchSortingOption.Healty", comment: ""),
        NSLocalizedString("RecipeSearchSortingOption.Harmful", comment: ""),
        NSLocalizedString("RecipeSearchSortingOption.TheLeastCaloric", comment: ""),
        NSLocalizedString("RecipeSearchSortingOption.TheMostHighCalorie", comment: ""),
    ]
}
