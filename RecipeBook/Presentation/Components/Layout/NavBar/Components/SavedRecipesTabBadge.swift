//
//  SavedRecipesTabBadge.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI
import SwiftData


struct SavedRecipesTabBadge: View {
    @Environment(\.modelContext) var modelContext: ModelContext
    
    @State var savedRecipesCount: Int = 0
    
    var badgeText: String {
        savedRecipesCount < 100
        ? String(savedRecipesCount)
        : "99+"
        
    }
    
    var body: some View {
        ZStack {
            if savedRecipesCount != 0 {
                TabBadge(
                    text: badgeText
                )
            }
        }
        .onAppear {
            countSavedRecipes()
        }
        .onNotification(.savedRecipesDidUpdated) {
            countSavedRecipes()
        }
    }
    
    func countSavedRecipes() {
        withAnimation(.spring(duration: 0.2)) {
            do {
                let fetchDescriptor = FetchDescriptor<SavedRecipeModel>()
                savedRecipesCount = try modelContext.fetchCount(fetchDescriptor)
            } catch {
                print("error while fetching saved recipes count")
            }
        }
    }
}

#Preview {
    SavedRecipesTabBadge()
        .modelContainer(for: SavedRecipeModel.self, inMemory: true)
}
