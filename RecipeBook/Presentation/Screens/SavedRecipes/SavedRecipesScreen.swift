//
//  SavedRecipesView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI
import SwiftData


struct SavedRecipesScreen: View {
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject var tabBarSettings: TabBarSettings
    @State var viewModel: SavedRecipesViewModel
    
    var body: some View {
        NavigationStack {
                ZStack(alignment: .bottom) {
                    SavedRecipesList(
                        savedRecipes: viewModel.filteredRecipes,
                        rowBackgroundColor: .backgroundLayer1,
                        selectedRecipesIds: $viewModel.selectedRecipesIds,
                        isEditModeEnabled: $viewModel.isEditModeEnabled,
                        onRemoveSingle: viewModel.removeSingleRecipe
                    )
                    
                    SavedRecipesFloatingActionBar(
                        selectedRecipesCount: viewModel.selectedRecipesIds.count,
                        isEditModeEnabled: $viewModel.isEditModeEnabled,
                        onRemoveSelected: viewModel.removeSelectedFromSaved
                    )
            }
            .background(.backgroundLayer1)
            .searchable(text: $viewModel.query)
            .toolbar {
                SavedRecipesToolbar(
                    savedRecipes: $viewModel.savedRecipes,
                    selectedRecipesIds: $viewModel.selectedRecipesIds,
                    isEditModeEnabled: $viewModel.isEditModeEnabled
                )
            }
            .applyCustomNavigationBarTitle("Saved")
            .applyDefaultTopBarStyle()
        }
        .tint(.toolbarItemAccent)
        
        
        .onAppear {
            viewModel.modelContext = modelContext
            viewModel.fetchRecipes()
            toggleTabBarShadow(!viewModel.isEditModeEnabled)
        }
        .onDisappear {
            toggleTabBarShadow(true)
        }
        .onChange(of: viewModel.isEditModeEnabled) {
            toggleTabBarShadow(!viewModel.isEditModeEnabled)
        }
        .onNotification(.savedRecipesDidUpdated) {
            viewModel.fetchRecipes()
        }
    }
    
    func toggleTabBarShadow(_ isShowing: Bool) {
        withAnimation(tabBarSettings.shadowAnimation) {
            tabBarSettings.isShadowShowing = isShowing
        }
    }
}


#Preview {
    SavedRecipesScreen(
        viewModel: SavedRecipesViewModel()
    )
    .environmentObject(TabBarSettings())
    .modelContainer(for: SavedRecipeModel.self, inMemory: true)
}
