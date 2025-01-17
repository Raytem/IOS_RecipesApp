//
//  SavedRecipeToolbar.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI

struct SavedRecipesToolbar: ToolbarContent {
    @Binding var savedRecipes: [SavedRecipeModel]
    @Binding var selectedRecipesIndexes: Set<Int>
    @Binding var isEditModeEnabled: Bool
    
    var selectButtonText: LocalizedStringKey {
        isEditModeEnabled ? "Cancel" : "Select"
    }
    
    var selectAllButtonText: LocalizedStringKey {
        savedRecipes.count == selectedRecipesIndexes.count
        ? "Reset"
        : "Select All"
    }
    
    var body: some ToolbarContent {
        if (isEditModeEnabled) {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: handleSelectAllButtonClick) {
                    Text(selectAllButtonText)
                }
            }
        }
        if (!savedRecipes.isEmpty) {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: handleSelectButtonClick) {
                    Text(selectButtonText)
                }
            }
        }
    }
    
    func handleSelectAllButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            if selectedRecipesIndexes.count == savedRecipes.count {
                selectedRecipesIndexes = Set()
            } else {
                if !savedRecipes.isEmpty {
                    selectedRecipesIndexes = Set(0..<savedRecipes.count)
                }
            }
        }
    }
    
    func handleSelectButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            selectedRecipesIndexes.removeAll()
            isEditModeEnabled.toggle()
        }
    }
}

#Preview {
//    SavedRecipesToolbar(
//        savedRecipes: .constant(savedRecipeMockData),
//        selectedRecipes: .constant(Set()),
//        isEditModeEnabled: .constant(true)
//    )
}
