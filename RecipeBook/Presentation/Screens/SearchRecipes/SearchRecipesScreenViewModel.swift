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
    
    // sheets & alerst
    var isSearchablePresented = false
    var isFiltersSheetShowing = false
    var isSortingOptionsSheetShowing = false
    var isShowingErrorAlert = false
    
    var cardViewType: RecipeCardViewType
    var startQueryText: String
    var tempQueryText: String = ""
    var filters: SearchRecipesFilter
    var sortBy: SearchRecipesSortOption
    var searchSuggestions: [String] = ["test 1", "test 2"] //TDOO: delete mock
    
    // pagination
    var currentPage: Int = 0
    var lastPage: Int = 1
    var isRecipesLoading = true
    
    init (
        recipesModels: [RecipeModel],
        cardViewType: RecipeCardViewType = .grid,
        filters: SearchRecipesFilter = SearchRecipesFilter(),
        sortBy: SearchRecipesSortOption = .popular,
        startQueryText: String = "",
        tempQueryText: String = ""
    ) {
        self.recipesModels = recipesModels
        self.cardViewType = cardViewType
        self.filters = filters
        self.sortBy = sortBy
        self.startQueryText = startQueryText
        self.tempQueryText = tempQueryText
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
            filters: SearchRecipesFilter(),
            startQueryText: startQueryText ?? tempQueryText,
            tempQueryText: tempQueryText
        )
    }
    
    func getSortOptionFormattedDisplayName(for option: SearchRecipesSortOption) -> String {
        if option != sortBy {
            return option.displayName
        }
        return "• \(option.displayName) •"
    }
    
    private func resetRecipes() {
        isRecipesLoading = true
        currentPage = 0
        recipesModels = []
    }
    
    func updateSortBy(to newValue: SearchRecipesSortOption) {
            if newValue != sortBy {
                resetRecipes()
                sortBy = newValue
                fetchRecipes()
            }
        }

    func applyFilters() {
        resetRecipes()
        fetchRecipes()
    }

    func refreshData() {
        resetRecipes()
        fetchRecipes()
    }
    
    func fetchRecipes() -> Void {
        if currentPage >= lastPage {
            return
        }
        
        currentPage = currentPage + 1
        
        if currentPage <= 1 {
            isRecipesLoading = true
        }
        
        // for testing
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            self.recipesModels.append(contentsOf: getNewRicipeMockData())
//            self.lastPage = self.lastPage + 1
//            self.isRecipesLoading = false
//        }
        
        RecipeRepository.shared.getManyRecipes(
            query: tempQueryText,
            filters: filters,
            sortBy: sortBy,
            page: currentPage,
            perPage: 10
        ) { result in
            switch result {
            case .success(let paginatedData):
                self.recipesModels.append(contentsOf: paginatedData.data)
                self.lastPage = paginatedData.lastPage
                self.isRecipesLoading = false
            case .failure(let error):
                print(error)
                self.isRecipesLoading = false
                self.isShowingErrorAlert = true
            }
        }
    }
    
}
