//
//  SavedRecipesView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI

struct SavedRecipesView: View {
    var body: some View {
        ContentUnavailableView {
            Label("No saved recipes", systemImage: "bookmark.slash")
        } description: {
            Text("Search for recipes and add it to saved")
        }
    }
}

#Preview {
    SavedRecipesView()
}
