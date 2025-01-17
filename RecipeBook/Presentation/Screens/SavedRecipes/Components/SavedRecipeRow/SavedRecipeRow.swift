//
//  SavedRecipeRow.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI


struct SavedRecipeRow: View {
    var recipe: SavedRecipeModel
    var isSelected: Bool
    @Binding var isEditModeEnabled: Bool
    var onRemove: (_ savedRecipe: SavedRecipeModel) -> Void
    var onSelect: (_ savedRecipe: SavedRecipeModel) -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            if isEditModeEnabled {
                Checkmark(isActive: isSelected)
            }
        
            SavedRecipeCard(
                savedRecipeModel: recipe,
                isNavigationLinkEnabled: isEditModeEnabled
                    ? .constant(false)
                    : .constant(true)
            )
        }
        .animation(.bouncy(duration: 0.3), value: isEditModeEnabled)
        .listRowInsets(.init())
        .listRowSeparator(.hidden)
        .listRowBackground(Color(.backgroundMain))
        .swipeActions(edge: .trailing) {
            Button(action: {
                onRemove(recipe)
            }) {
                Label("Remove", systemImage: "bookmark.slash")
            }
            .tint(Color(.secondary60))
        }
        .swipeActions(edge: .leading) {
            Button(action: { isEditModeEnabled = true }) {
                
            }
            .tint(Color.clear)
        }
        .overlay {
            if isEditModeEnabled {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onSelect(recipe)
                    }
            }
        }
    }
}

#Preview {
    SavedRecipeRow(
        recipe: savedRecipeMockData[0],
        isSelected: true,
        isEditModeEnabled: .constant(true),
        onRemove: { print("Removing: ", $0) },
        onSelect: { print("Selected: ", $0) }
    )
}
