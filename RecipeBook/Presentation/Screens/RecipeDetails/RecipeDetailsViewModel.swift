//
//  RecipeDetailsViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 15.01.25.
//

import Foundation
import SwiftUI


@Observable
class RecipeDetailsViewModel {
    var recipeId: Int
    var recipeDetailsPreview: RecipeDetailsPreview?
    var recipeDetailsModel: RecipeDetailsModel?
    var relatedRecipesModels: [RecipeModel] = []
    
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
}
