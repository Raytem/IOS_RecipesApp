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
    var selectedRecipesIndexes: Set<Int> = Set()
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
    
    func removeSingleRecipe(_ index: Int) {
        modelContext?.delete(filteredRecipes[index])
        savedRecipes.remove(at: index)
        startPostRemoveActions()
        
        NotificationCenter.default.post(name: .savedRecipesDidUpdated, object: nil)
    }
    
    func removeSelectedFromSaved() {
        for index in selectedRecipesIndexes {
            let recipeToDelete = filteredRecipes[index]
            modelContext?.delete(recipeToDelete)
            savedRecipes.remove(at: index)
        }
        selectedRecipesIndexes.removeAll()
        startPostRemoveActions()
        isEditModeEnabled = false
        
        NotificationCenter.default.post(name: .savedRecipesDidUpdated, object: nil)
    }
    
    private func startPostRemoveActions() {
        if isEditModeEnabled && savedRecipes.isEmpty {
            isEditModeEnabled = false
        }
    }
}
