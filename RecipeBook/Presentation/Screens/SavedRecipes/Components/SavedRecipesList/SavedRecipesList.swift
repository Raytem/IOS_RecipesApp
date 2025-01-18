//
//  SavedRecipesList.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI

struct SavedRecipesList: View {
    var savedRecipes: [SavedRecipeModel]
    var rowBackgroundColor: Color
    @Binding var selectedRecipesIds: Set<Int>
    @Binding var isEditModeEnabled: Bool
    var onRemoveSingle: (_ index: Int) -> Void
    
    var body: some View {
        if savedRecipes.isEmpty {
            ContentUnavailableView(
                String(localized: "There are no saved recipes", table: "SavedRecipesScreen"),
                systemImage: "bookmark.slash",
                description: Text(
                    String(
                        localized: "Find the recipes that suit you and save them for easy access later",
                        table: "SavedRecipesScreen"
                    )
                )
            )
        } else {
            List {
                ForEach(savedRecipes, id: \.id) { recipe in
                    SavedRecipeRow(
                        recipe: recipe,
                        backgroundColor: rowBackgroundColor,
                        isSelected: isItemSelected(recipe.id),
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
    }
    
    func isItemSelected(_ id: Int) -> Bool {
        selectedRecipesIds.contains(id)
    }
    
    func handleSelectItem(_ id: Int) {
        withAnimation(.spring(duration: 0.2)) {
            if (selectedRecipesIds.contains(id)) {
                selectedRecipesIds.remove(id)
            } else {
                selectedRecipesIds.insert(id)
            }
        }
    }
    
    func handleRemoveSingleButtonClick(_ index: Int) {
        withAnimation(.spring(duration: 0.2)) {
            onRemoveSingle(index)
        }
    }
}

#Preview {
    SavedRecipesList(
        savedRecipes: savedRecipeMockData,
        rowBackgroundColor: .backgroundLayer1,
        selectedRecipesIds: .constant(Set()),
        isEditModeEnabled: .constant(true),
        onRemoveSingle: { print($0) }
    )
}
