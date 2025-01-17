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
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var tabBarSettings: TabBarSettings
    @State var viewModel: SavedRecipesViewModel
    
    var body: some View {
        NavigationStack {
                ZStack(alignment: .bottom) {
                    SavedRecipesList(
                        savedRecipes: viewModel.filteredRecipes,
                        selectedRecipesIndexes: $viewModel.selectedRecipesIndexes,
                        isEditModeEnabled: $viewModel.isEditModeEnabled,
                        onRemoveSingle: viewModel.removeSingleRecipe
                    )
                    
                    SavedRecipesFloatingActionBar(
                        selectedRecipesCount: viewModel.selectedRecipesIndexes.count,
                        isEditModeEnabled: $viewModel.isEditModeEnabled,
                        onRemoveSelected: viewModel.removeSelectedFromSaved
                    )
            }
            .background(.backgroundMain)
            .searchable(text: $viewModel.query)
            .toolbar {
                SavedRecipesToolbar(
                    savedRecipes: $viewModel.savedRecipes,
                    selectedRecipesIndexes: $viewModel.selectedRecipesIndexes,
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
