//
//  SavedRecipesViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import Foundation


@Observable
class SavedRecipesViewModel {
    var savedRecipes: [SavedRecipeModel]
    var selectedRecipes: Set<SavedRecipeModel> = Set([])
    
    var isEditModeEnabled: Bool = false
    
    var query: String = ""
    
    init(
        savedRecipes: [SavedRecipeModel] = savedRecipeMockData // TDODO: remove mock
    ) {
        self.savedRecipes = savedRecipes
    }
}
