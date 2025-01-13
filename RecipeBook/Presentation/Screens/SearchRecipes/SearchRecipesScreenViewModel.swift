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
    
    var isSearchablePresented = false
    var isFiltersSheetShowing = false
    var isSortingOptionsSheetShowing = false
    
    var currentPage: Int = 0
    var totalPages: Int = 4 // TODO: get from server
    var isRecipesLoading = true
    
    var cardViewType: RecipeCardViewType
    var startQueryText: String
    var tempQueryText: String = ""
    var filters: SearchRecipesFilter
    var sortBy: SearchRecipesSortOption
    var searchSuggestions: [String] = ["test 1", "test 2"] //TDOO: delete mock
    
    init (
        recipesModels: [RecipeModel],
        cardViewType: RecipeCardViewType = .grid,
        filters: SearchRecipesFilter = SearchRecipesFilter(),
        sortBy: SearchRecipesSortOption = .popular,
        startQueryText: String = ""
    ) {
        self.recipesModels = recipesModels
        self.cardViewType = cardViewType
        self.filters = filters
        self.sortBy = sortBy
        self.startQueryText = startQueryText
    }

    var showFiltersBadge: Bool {
        return !(
            filters.mealTypes.isEmpty
            && filters.cuisines.isEmpty
            && filters.diets.isEmpty
            && filters.maxReadyTime == nil
        )
    }
    
    func getNewInstanceForNewSearchRequest(
        startQueryText: String? = nil
    ) -> SearchRecipesScreenViewModel {
        return SearchRecipesScreenViewModel(
            recipesModels: [],
            cardViewType: cardViewType,
            filters: filters,
            startQueryText: startQueryText ?? tempQueryText
        )
    }
    
    func getSortOptionFormattedDisplayName(for option: SearchRecipesSortOption) -> String {
        if option != sortBy {
            return option.displayName
        }
        return "• \(option.displayName) •"
    }
}
