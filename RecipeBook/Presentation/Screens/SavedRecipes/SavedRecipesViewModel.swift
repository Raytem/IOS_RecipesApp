//
//  SavedRecipesViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import Foundation
import SwiftData
import SwiftUI


@Observable
class SavedRecipesViewModel {
    var modelContext: ModelContext? = nil
    
    var savedRecipes: [SavedRecipeModel] = []
    var selectedRecipesIds: Set<Int> = Set()
    var query: String = ""
    var isEditModeEnabled: Bool = false
    
    var filteredRecipes: [SavedRecipeModel] {
        if !query.isEmpty {
            return savedRecipes.filter {
                $0.title.lowercased().contains(query.lowercased())
            }
        }
        return savedRecipes
    }
    
    func fetchRecipes() {
        let fetchDescriptor = FetchDescriptor<SavedRecipeModel>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        do {
            let data = try modelContext?.fetch(fetchDescriptor)
            if let data {
                savedRecipes = data
            }
        } catch {
            print("error while fetching saved recipes")
        }
    }
    
    func removeSingleRecipe(_ recipeId: Int) {
        do {
            // removing from local db
            try modelContext?.delete(
                model: SavedRecipeModel.self,
                where: #Predicate {
                    $0.id == recipeId
                }
            )
            // removing from state
            savedRecipes.removeAll(where: { $0.id == recipeId })
            
            // removing from selected
            selectedRecipesIds.remove(recipeId)
            
            startPostRemoveActions()
            
            NotificationCenter.default.post(name: .savedRecipesDidUpdated, object: nil)
        } catch {
            print("Error while removing saved recipes")
        }
    }
    
    func removeSelectedFromSaved() {
        do {
            // removing from local db
            let recipeIdsToDelete = Array(selectedRecipesIds)
            try modelContext?.delete(
                model: SavedRecipeModel.self,
                where: #Predicate {
                    recipeIdsToDelete.contains($0.id)
                }
            )
            // removing from state
            savedRecipes.removeAll(where: { recipeIdsToDelete.contains($0.id) })
            
            // clear selected recipes
            selectedRecipesIds.removeAll()
            
            startPostRemoveActions()
            isEditModeEnabled = false
            
            NotificationCenter.default.post(name: .savedRecipesDidUpdated, object: nil)
        } catch {
            print("Error while removing saved recipes")
        }
    }
    
    private func startPostRemoveActions() {
        if isEditModeEnabled && savedRecipes.isEmpty {
            isEditModeEnabled = false
        }
    }
}
