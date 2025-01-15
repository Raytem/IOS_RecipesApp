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
    
    var isAboutRecipeSheetShowing = false
    var isIngredientsSheeShowing = false
    
    var isDetailsLoading = true
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
    }
}
