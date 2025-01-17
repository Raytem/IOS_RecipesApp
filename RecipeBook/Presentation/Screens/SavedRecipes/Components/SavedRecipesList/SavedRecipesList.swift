//
//  SavedRecipesList.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI

struct SavedRecipesList: View {
    var savedRecipes: [SavedRecipeModel]
    @Binding var selectedRecipesIndexes: Set<Int>
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
                        if let index = savedRecipes.firstIndex(where: { $0.id == recipe.id }) {
                           SavedRecipeRow(
                               recipe: recipe,
                               index: index,
                               isSelected: isItemSelected(index),
                               isEditModeEnabled: $isEditModeEnabled,
                               onRemove: { handleRemoveSingleButtonClick($0) },
                               onSelect: { handleSelectItem($0) }
                           )
                        }
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
    
    func isItemSelected(_ index: Int) -> Bool {
        selectedRecipesIndexes.contains(index)
    }
    
    func handleSelectItem(_ index: Int) {
        withAnimation(.spring(duration: 0.2)) {
            if (selectedRecipesIndexes.contains(index)) {
                selectedRecipesIndexes.remove(index)
            } else {
                selectedRecipesIndexes.insert(index)
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
        selectedRecipesIndexes: .constant(Set()),
        isEditModeEnabled: .constant(true),
        onRemoveSingle: { print($0) }
    )
}
