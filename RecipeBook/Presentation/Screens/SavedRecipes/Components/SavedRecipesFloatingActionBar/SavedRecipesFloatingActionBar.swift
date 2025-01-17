//
//  SavedRecipesFloatingActionBar.swift
//  RecipeBook
//
//  Created by Daniil on 17.01.25.
//

import SwiftUI

struct SavedRecipesFloatingActionBar: View {
    var selectedRecipesCount: Int
    @Binding var isEditModeEnabled: Bool
    var onRemoveSelected: () -> Void
    
    var removeButtonText: LocalizedStringKey {
        if (
            isEditModeEnabled
            && selectedRecipesCount != 0
        ) {
            return "Remove: \(selectedRecipesCount)"
        } else {
            return "Remove"
        }
    }
    
    var body: some View {
        FloatingActionBar(
            position: .bottom
        ) {
            CustomButton(
                title: removeButtonText,
                color: .secondary,
                startIcon: "bookmark.slash",
                fullWidth: true,
                disabled: selectedRecipesCount == 0,
                action: handleRemoveSelectedButtonClick
            )
        }
        .opacity(isEditModeEnabled ? 1 : 0)
        .padding(.bottom, isEditModeEnabled ? 0 : -UIScreen.main.bounds.height)
    }
    
    func handleRemoveSelectedButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            onRemoveSelected()
        }
    }
}

#Preview {
    SavedRecipesFloatingActionBar(
        selectedRecipesCount: 2,
        isEditModeEnabled: .constant(true),
        onRemoveSelected: {}
    )
}
