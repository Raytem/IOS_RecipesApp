//
//  SavedRecipesList.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI

struct SavedRecipesList: View {
    var savedRecipes: [SavedRecipeModel]
    @Binding var selectedRecipes: Set<SavedRecipeModel>
    @Binding var isEditModeEnabled: Bool
    var onRemoveSingle: (_ recipe: SavedRecipeModel) -> Void
    
    var body: some View {
        List {
            ForEach(savedRecipes, id: \.id) { recipe in
                SavedRecipeRow(
                    recipe: recipe,
                    isSelected: isItemSelected(recipe),
                    isEditModeEnabled: $isEditModeEnabled,
                    onRemove: { handleRemoveSingleButtonClick($0) },
                    onSelect: { handleSelectItem($0) }
                )
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .listRowSpacing(20)
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .safeAreaPadding(.bottom, 80)
    }
    
    func isItemSelected(_ item: SavedRecipeModel) -> Bool {
        selectedRecipes.contains(item)
    }
    
    func handleSelectItem(_ item: SavedRecipeModel) {
        withAnimation(.spring(duration: 0.2)) {
            if (selectedRecipes.contains(item)) {
                selectedRecipes.remove(item)
            } else {
                selectedRecipes.insert(item)
            }
        }
    }
    
    func handleRemoveSingleButtonClick(_ item: SavedRecipeModel) {
        withAnimation(.spring(duration: 0.2)) {
            onRemoveSingle(item)
        }
    }
}

#Preview {
    SavedRecipesList(
        savedRecipes: savedRecipeMockData,
        selectedRecipes: .constant(Set([savedRecipeMockData[0]])),
        isEditModeEnabled: .constant(true),
        onRemoveSingle: { print($0) }
    )
}
