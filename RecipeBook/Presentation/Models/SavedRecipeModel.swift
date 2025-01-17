//
//  SavedRecipeModel.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import Foundation
import SwiftUI
import SwiftData


@Model
class SavedRecipeModel: Identifiable {
    @Attribute(.unique) var id: Int
    
    var title: String
    
    var image: URL?
    
    var readyInMinutes: Int
    
    var createdAt: Date
    
    init(
        id: Int,
        title: String,
        image: URL?,
        readyInMinutes: Int,
        createdAt: Date = Date.now
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.readyInMinutes = readyInMinutes
        self.createdAt = createdAt
    }
}
