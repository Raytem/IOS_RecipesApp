//
//  SearchRecipesScreenViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 7.01.25.
//

import SwiftUI

@Observable
class SearchRecipesScreenViewModel {
    var recipesModels: [RecipeModel]
    
    var isFiltersSheetShowing = false
    var isSortingOptionsSheetShowing = false
    var isRecipesLoading = true
    
    var tempQueryText = ""
    var filters = SearchRecipesFilter()
    var sortBy: SearchRecipesSortOption
    
    init (
        recipesModels: [RecipeModel],
        sortBy: SearchRecipesSortOption = .popular
    ) {
        self.recipesModels = recipesModels
        self.sortBy = sortBy
    }
    
    func handleSortByUpdate(new value: SearchRecipesSortOption) {
        sortBy = value
    }
    
    func getSortOptionFormattedDisplayName(for option: SearchRecipesSortOption) -> String {
        if option != sortBy {
            return option.displayName
        }
        return "• \(option.displayName) •"
    }
}
