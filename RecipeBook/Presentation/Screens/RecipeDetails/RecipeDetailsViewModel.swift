//
//  RecipeDetailsViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import Foundation
import SwiftUI
import SwiftData


@Observable
class RecipeDetailsViewModel {
    var modelContext: ModelContext? = nil
    
    var recipeId: Int
    var recipeDetailsPreview: RecipeDetailsPreview?
    var recipeDetailsModel: RecipeDetailsModel?
    var relatedRecipesModels: [RecipeModel] = []
    
    var isSaved: Bool = false
    var isAboutRecipeSheetShowing = false
    var isIngredientsSheetShowing = false
    
    var isDetailsLoading = true
    var isRelatedRecipesLoading = true
    var isShowingErrorAlert = false
    
    init(
        recipeId: Int,
        recipeDetailsPreview: RecipeDetailsPreview? = nil,
        recipeDetailsModel: RecipeDetailsModel? = nil
    ) {
        self.recipeId = recipeId
        self.recipeDetailsPreview = recipeDetailsPreview
        self.recipeDetailsModel = recipeDetailsModel
    }
    
    func fetchRecipeDetails() {
        
        // TODO: for test
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.recipeDetailsModel = recipeDetailsMockData
            self.isDetailsLoading = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.relatedRecipesModels = recipeCardMockData
            self.isRelatedRecipesLoading = false
        }
//
//        isDetailsLoading = true
//        RecipeRepository.shared.getRecipeDetails(id: recipeId) { result in
//            switch result {
//            case .success(let recipeDetails):
//                self.recipeDetailsModel = recipeDetails
//                self.isDetailsLoading = false
//            case .failure(let error):
//                print(error)
//                self.isDetailsLoading = false
//                self.isShowingErrorAlert = true
//            }
//        }
//        
//        isRelatedRecipesLoading = true
//        RecipeRepository.shared.getRelatedRecipes(for: recipeId) { result in
//            switch result {
//            case .success(let relatedRecipes):
//                self.relatedRecipesModels = relatedRecipes
//                self.isRelatedRecipesLoading = false
//            case .failure(let error):
//                print(error)
//                self.isRelatedRecipesLoading = false
//                self.isShowingErrorAlert = true
//            }
//        }
        
    }
    
    private func isRecipeSaved() -> Bool {
        do {
            let id = recipeId
            let fetchDescriptor = FetchDescriptor<SavedRecipeModel>(predicate: #Predicate { $0.id == id })
            let count = try modelContext?.fetchCount(fetchDescriptor) ?? 0
            return count > 0
        } catch {
           print("Error checking if recipe is saved", error)
           return false
        }
    }
    
    private func removeFromSaved() {
        do {
            let targetId = recipeId
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
            if let recipe = recipeDetailsModel {
                let savedRecipe = SavedRecipeModel(
                    id: recipeId,
                    title: recipe.title,
                    image: recipe.image,
                    readyInMinutes: recipe.readyInMinutes
                )
                modelContext?.insert(savedRecipe)
                try modelContext?.save()
                isSaved = true
            }
            
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
