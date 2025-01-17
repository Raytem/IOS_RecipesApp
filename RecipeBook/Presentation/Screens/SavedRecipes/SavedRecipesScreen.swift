//
//  SavedRecipesView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI


struct SavedRecipesScreen: View {
    @EnvironmentObject var tabBarSettings: TabBarSettings
    @State var viewModel: SavedRecipesViewModel
    
    var body: some View {
        NavigationStack {
                ZStack(alignment: .bottom) {
                    SavedRecipesList(
                        savedRecipes: viewModel.filteredRecipes,
                        selectedRecipes: $viewModel.selectedRecipes,
                        isEditModeEnabled: $viewModel.isEditModeEnabled,
                        onRemoveSingle: viewModel.removeSingleRecipe
                    )
                    
                    SavedRecipesFloatingActionBar(
                        selectedRecipesCount: viewModel.selectedRecipes.count,
                        isEditModeEnabled: $viewModel.isEditModeEnabled,
                        onRemoveSelected: viewModel.removeSelectedFromSaved
                    )
            }
            .background(.backgroundMain)
            .searchable(text: $viewModel.query)
            .toolbar {
                SavedRecipesToolbar(
                    savedRecipes: $viewModel.savedRecipes,
                    selectedRecipes: $viewModel.selectedRecipes,
                    isEditModeEnabled: $viewModel.isEditModeEnabled
                )
            }
            .applyCustomNavigationBarTitle("Saved Recipes")
            .applyDefaultTopBarStyle()
        }
        .tint(.toolbarItemAccent)
        
        
        .onChange(of: viewModel.isEditModeEnabled) {
            toggleTabBarShadow(!viewModel.isEditModeEnabled)
        }
        .onAppear {
            toggleTabBarShadow(!viewModel.isEditModeEnabled)
        }
        .onDisappear {
            toggleTabBarShadow(true)
        }
    }
    
    func toggleTabBarShadow(_ isShowing: Bool) {
        withAnimation(.linear(duration: 0.2)) {
            tabBarSettings.isShadowShowing = isShowing
        }
    }
}

#Preview {
    SavedRecipesScreen(
        viewModel: SavedRecipesViewModel()
    )
    .environmentObject(TabBarSettings())
}
