//
//  SavedRecipeModel.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI


struct SavedRecipeModel: Identifiable, Hashable {
    var id: Int
    var title: String
    var image: URL?
    var readyInMinutes: Int
}
