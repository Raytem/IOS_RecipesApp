//
//  RecipeCardViewModel.swift
//  RecipeBook
//
//  Created by Daniil on 8.01.25.
//

import SwiftUI


@Observable
class RecipeCardViewModel {
    public var recipeModel: RecipeModel
    
    init(recipeModel: RecipeModel) {
        self.recipeModel = recipeModel
    }
}
