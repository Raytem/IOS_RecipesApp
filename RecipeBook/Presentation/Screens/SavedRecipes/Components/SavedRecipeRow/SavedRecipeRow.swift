//
//  SavedRecipeRow.swift
//  RecipeBook
//
//  Created by Daniil on 16.01.25.
//

import SwiftUI


struct SavedRecipeRow: View {
    var recipe: SavedRecipeModel
    var backgroundColor: Color
    var isSelected: Bool
    @Binding var isEditModeEnabled: Bool
    var onRemove: (_ index: Int) -> Void
    var onSelect: (_ index: Int) -> Void
    
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
        .listRowBackground(backgroundColor)
        .swipeActions(edge: .trailing) {
            Button(action: {
                onRemove(recipe.id)
            }) {
                Label("Remove", systemImage: "bookmark.slash")
            }
            .tint(Color(.secondary60))
        }
        .overlay {
            if isEditModeEnabled {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onSelect(recipe.id)
                    }
            }
        }
    }
}

#Preview {
    SavedRecipeRow(
        recipe: savedRecipeMockData[0],
        backgroundColor: .backgroundLayer1,
        isSelected: true,
        isEditModeEnabled: .constant(true),
        onRemove: { print("Removing: ", $0) },
        onSelect: { print("Selected: ", $0) }
    )
}
