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
    
    var filteredRecipes: [SavedRecipeModel] {
        if !query.isEmpty {
            return savedRecipes.filter {
                $0.title.lowercased().contains(query.lowercased())
            }
        }
        return savedRecipes
    }
    
    init(
        savedRecipes: [SavedRecipeModel] = savedRecipeMockData // TDODO: remove mock
    ) {
        self.savedRecipes = savedRecipes
    }
    
    func removeSingleRecipe(_ recipeToRemove: SavedRecipeModel) {
        savedRecipes.removeAll(where: {
            $0 == recipeToRemove
        })
        startPostRemoveActions()
    }
    
    func removeSelectedFromSaved() {
        savedRecipes.removeAll { savedRecipe in
            selectedRecipes.contains(savedRecipe)
        }
        selectedRecipes.removeAll()
        startPostRemoveActions()
        
        isEditModeEnabled = false
    }
    
    private func startPostRemoveActions() {
        if isEditModeEnabled && savedRecipes.isEmpty {
            isEditModeEnabled = false
        }
    }
}
