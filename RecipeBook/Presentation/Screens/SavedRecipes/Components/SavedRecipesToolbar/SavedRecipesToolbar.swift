//
//  SavedRecipeToolbar.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI

struct SavedRecipesToolbar: ToolbarContent {
    @Binding var savedRecipes: [SavedRecipeModel]
    @Binding var selectedRecipes: Set<SavedRecipeModel>
    @Binding var isEditModeEnabled: Bool
    
    var selectButtonText: LocalizedStringKey {
        isEditModeEnabled ? "Cancel" : "Select"
    }
    
    var selectAllButtonText: LocalizedStringKey {
        savedRecipes.count == selectedRecipes.count
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
            if selectedRecipes.count == savedRecipes.count {
                selectedRecipes = Set()
            } else {
                selectedRecipes = Set(savedRecipes)
            }
        }
    }
    
    func handleSelectButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            selectedRecipes.removeAll()
            isEditModeEnabled.toggle()
        }
    }
}

#Preview {
//    SavedRecipesToolbar(
//        savedRecipes: .constant(savedRecipeMockData),
//        selectedRecipes: .constant(Set([savedRecipeMockData[0]])),
//        isEditModeEnabled: .constant(true)
//    )
}
