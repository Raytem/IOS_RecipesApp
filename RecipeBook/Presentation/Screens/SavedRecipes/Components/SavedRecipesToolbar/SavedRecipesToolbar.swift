//
//  SavedRecipeToolbar.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI

struct SavedRecipesToolbar: ToolbarContent {
    @Binding var savedRecipes: [SavedRecipeModel]
    @Binding var selectedRecipesIds: Set<Int>
    @Binding var isEditModeEnabled: Bool
    
    var selectButtonText: LocalizedStringKey {
        isEditModeEnabled ? "Cancel" : "Select"
    }
    
    var selectAllButtonText: LocalizedStringKey {
        savedRecipes.count == selectedRecipesIds.count
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
        if (savedRecipes.count > 1) {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: handleSelectButtonClick) {
                    Text(selectButtonText)
                }
            }
        }
    }
    
    func handleSelectAllButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            if selectedRecipesIds.count == savedRecipes.count {
                selectedRecipesIds = Set()
            } else {
                if !savedRecipes.isEmpty {
                    selectedRecipesIds = Set(savedRecipes.map { $0.id })
                }
            }
        }
    }
    
    func handleSelectButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            selectedRecipesIds.removeAll()
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
