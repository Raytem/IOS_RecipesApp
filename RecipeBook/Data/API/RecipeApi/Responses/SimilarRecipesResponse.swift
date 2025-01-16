//
//  SimilarRecipesResponse.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import Foundation


struct SimilarRecipesResponse: Codable, Identifiable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
}
