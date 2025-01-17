//
//  RecipeCardViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI
import SwiftData


@Observable
class RecipeCardViewModel {
    var modelContext: ModelContext? = nil
    
    var recipeModel: RecipeModel
    var isSaved: Bool = false
    
    init(
        recipeModel: RecipeModel
    ) {
        self.recipeModel = recipeModel
    }
    
    private func isRecipeSaved() -> Bool {
        do {
            let targetId = recipeModel.id
            let fetchDescriptor = FetchDescriptor<SavedRecipeModel>(
                predicate: #Predicate { $0.id == targetId }
            )
            let count = try modelContext?.fetchCount(fetchDescriptor) ?? 0
            
            return count > 0
        } catch {
            print("Error while fetching count of recipe", error)
        }
        return false
    }
    
    private func removeFromSaved() {
        do {
            let targetId = recipeModel.id
            try modelContext?.delete(model: SavedRecipeModel.self, where: #Predicate {
                $0.id == targetId
            })
            try modelContext?.save()
            isSaved = false
            
            NotificationCenter.default.post(name: .savedRecipesDidUpdated, object: nil)
        } catch {
            print("Error while deleting recipe", error)
        }
    }
    
    private func addToSaved() {
        do {
            let savedRecipe = SavedRecipeModel(
                id: recipeModel.id,
                title: recipeModel.title,
                image: recipeModel.image,
                readyInMinutes: recipeModel.readyInMinutes
            )
            modelContext?.insert(savedRecipe)
            try modelContext?.save()
            isSaved = true
            
            NotificationCenter.default.post(name: .savedRecipesDidUpdated, object: nil)
        } catch {
            print("Error while saving recipe", error)
        }
    }
    
    func addToSavedOrRemove() {        
        if isRecipeSaved() {
            removeFromSaved()
        } else {
            addToSaved()
        }
    }
    
    func updateIsSavedState() {
        isSaved = isRecipeSaved()
    }
    
    
}

