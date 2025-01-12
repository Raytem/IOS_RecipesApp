//
//  SearchRecipesScreenView.swift
//  RecipeBook
//
//  Created by Daniil on 6.01.25.
//

import SwiftUI


struct SearchRecipesScreen: View {
    @State var viewModel: SearchRecipesScreenViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                RecipeCardList(
                    recipeModels: $viewModel.recipesModels,
                    cardViewType: $viewModel.filters.cardViewType,
                    isLoading: $viewModel.isRecipesLoading
                )
                .padding()
            }
            .background(.backgroundLayer1)
            
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    HStack {
                        Button(action: {
                            viewModel.isSortingOptionsSheetShowing.toggle()
                        }) {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                        
                        Button(action: {
                            viewModel.isFiltersSheetShowing.toggle()
                        }) {
                            Image(systemName: "slider.horizontal.3")
                        }
                    }
                    .fontWeight(.semibold)
                }
            }
            .applyCustomNavigationBarTitle(String(localized: "Search"))
            .applyDefaultTopBarStyle()
            
            // search input
            .searchable(text: $viewModel.tempQueryText, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable(action: {
                fetchRecipes()
            })
            
            // sorting dialog
            .confirmationDialog(
                "Sorting",
                isPresented: $viewModel.isSortingOptionsSheetShowing,
                titleVisibility: .visible
            ) {
                ForEach(SearchRecipesSortOption.allCases, id: \.self ) { option in
                    Button(action: {
                        viewModel.handleSortByUpdate(new: option)
                    }) {
                        Text(viewModel.getSortOptionFormattedDisplayName(for: option))
                    }
                }
            }
            
            // filters sheet
            .sheet(isPresented: $viewModel.isFiltersSheetShowing) {
                RecipeFilterScreen(
                    filters: $viewModel.filters,
                    handleFiltersApplly: handleFiltersApply
                )
            }
        }
        .accentColor(.toolbarItemAccent)
        .onAppear {
            fetchRecipes()
        }
    }
    
    private func handleFiltersApply() {
        print("SearchRecipesScreen.handleFiltersApply")
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        viewModel.isRecipesLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            //TODO: replace with real data
            viewModel.recipesModels = recipeCardMockData
            viewModel.isRecipesLoading = false
        }
    }
}

#Preview {
    SearchRecipesScreen(
        viewModel: SearchRecipesScreenViewModel(recipesModels: [])
    )
}
