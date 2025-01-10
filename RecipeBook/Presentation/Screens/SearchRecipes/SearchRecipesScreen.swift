//
//  SearchRecipesScreenView.swift
//  RecipeBook
//
//  Created by Daniil on 6.01.25.
//

import SwiftUI

struct SearchRecipesScreen: View {
    @State private var viewModel = SearchRecipesScreenViewModel(recipesModels: [])
    
    @State private var isRecipesLoading = true
    @State private var tempQueryText = ""
    
    var body: some View {
        NavigationStack {
            RecipeCardList(
                recipeModels: $viewModel.recipesModels,
                cardViewType: $viewModel.filters.cardViewType,
                isLoading: $isRecipesLoading
            )
            .navigationBarTitleDisplayMode(.inline)
            
            .searchable(text: $tempQueryText, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable(action: {
                fetchRecipes()
            })
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("SearchRecipesScreen.Title")
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
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
            .toolbarBackground(.primary50, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .accentColor(.toolbarItemAccent)
            
            // sorting dialog
            .confirmationDialog(
                "SortingConfirmationDialog.Title",
                isPresented: $viewModel.isSortingOptionsSheetShowing,
                titleVisibility: .visible
            ) {
                ForEach(viewModel.sortingOptions, id: \.self ) { title in
                    Button(action: {
                        
                    }) {
                        Text(title)
                    }
                }
            }
            
            // filters sheet
            .sheet(isPresented: $viewModel.isFiltersSheetShowing) {
                Picker("View mode", selection: $viewModel.filters.cardViewType) {
                    ForEach(RecipeCardViewType.allCases, id: \.self) { type in
                        let imageSystemName = switch type {
                        case .grid: "square.grid.2x2.fill"
                        case .list: "list.dash"
                        case .single: "square.fill"
                        }
                        Image(systemName: imageSystemName)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Spacer()
            }
        }
        .onAppear {
            fetchRecipes()
        }
    }
    
    private func fetchRecipes() {
        isRecipesLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                //TODO: replace with real data
                viewModel.recipesModels = recipeCardMockData
                isRecipesLoading = false
            }
        }
}

#Preview {
    SearchRecipesScreen()
}
