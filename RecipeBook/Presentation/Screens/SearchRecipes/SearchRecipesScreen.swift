//
//  SearchRecipesScreenView.swift
//  RecipeBook
//
//  Created by Daniil on 6.01.25.
//

import SwiftUI


struct SearchRecipesScreen: View {
    @State var viewModel: SearchRecipesScreenViewModel
    
    @State private var isNavigateToNewSearchPage: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                RecipeCardList(
                    recipeModels: $viewModel.recipesModels,
                    cardViewType: $viewModel.cardViewType,
                    isLoading: $viewModel.isRecipesLoading,
                    onLastListElementAppear: onLastListTiemElementAppear
                )
                .padding()
                
                // Navigation link for transitioning to the search results screen
                NavigationLink(
                    destination: SearchRecipesScreen(
                        viewModel: viewModel.getNewInstanceForNewSearchRequest()
                    ),
                    isActive: $isNavigateToNewSearchPage
                ) { EmptyView() }
            }
            .background(.backgroundLayer1)
            
            // searchable
            .searchable(
                text: $viewModel.tempQueryText,
                isPresented: $viewModel.isSearchablePresented,
                placement: .navigationBarDrawer(displayMode: .always)
            )
            .refreshable { handleRefreshData() }
            .onSubmit(of: .search) { handleSearchSubmit() }
//            .searchSuggestions {
//                ForEach(viewModel.searchSuggestions, id: \.self) { suggestion in
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundStyle(Color(.gray))
//                        Text(suggestion)
//                            .foregroundStyle(Color(.label))
//                        Spacer()
//                        Image(systemName: "chevron.forward")
//                            .foregroundStyle(Color(.gray))
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .contentShape(Rectangle())
//                    .onTapGesture {
//                        viewModel.tempQueryText = suggestion
//                        handleSearchSubmit()
//                    }
//                }
//            }
            
            // toolbar
            .toolbar {
                if !viewModel.isRecipesLoading {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        HStack {
                            Button(action: handleSortByButtonClick) {
                                Image(systemName: "arrow.up.arrow.down")
                            }
                            
                            Button(action: handleFiltersButtonClick) {
                                Image(systemName: "slider.horizontal.3")
                                    .overlay {
                                        if viewModel.showFiltersBadge {
                                            Circle()
                                                .fill(Color(.badge))
                                                .frame(width: 10)
                                                .offset(x: 10, y: -10)
                                        }
                                    }
                            }
                        }
                        .fontWeight(.semibold)
                    }
                }
            }
            .applyCustomNavigationBarTitle("Search")
            .applyDefaultTopBarStyle()
            
            // sorting dialog
            .confirmationDialog(
                "Sorting",
                isPresented: $viewModel.isSortingOptionsSheetShowing,
                titleVisibility: .visible
            ) {
                ForEach(SearchRecipesSortOption.allCases, id: \.self ) { option in
                    Button(action: {
                        handleSortByUpdate(new: option)
                    }) {
                        Text(viewModel.getSortOptionFormattedDisplayName(for: option))
                    }
                }
            }
            
            // filters sheet
            .sheet(isPresented: $viewModel.isFiltersSheetShowing) {
                RecipeFilterScreen(
                    filters: $viewModel.filters,
                    cardViewType: $viewModel.cardViewType,
                    handleFiltersApplly: { handleFiltersAppllyButtonClick() }
                )
            }
        }
        .accentColor(.toolbarItemAccent)
        
        .onAppear {
            viewModel.tempQueryText = viewModel.startQueryText
        }
        .onDisappear {
            viewModel.tempQueryText = viewModel.startQueryText
        }
    }
    
    private func handleSortByButtonClick() {
        viewModel.isSortingOptionsSheetShowing.toggle()
    }
    
    private func handleFiltersButtonClick() {
        viewModel.isFiltersSheetShowing.toggle()
    }
    
    private func handleSearchSubmit() {
        isNavigateToNewSearchPage = true
        viewModel.isSearchablePresented = false
    }
    
    private func handleSortByUpdate(new value: SearchRecipesSortOption) {
        if value != viewModel.sortBy {
            viewModel.currentPage = 0
            viewModel.recipesModels = []
            viewModel.sortBy = value
            viewModel.isRecipesLoading = true
        }
    }
    
    private func handleFiltersAppllyButtonClick() {
        viewModel.currentPage = 0
        viewModel.recipesModels = []
        viewModel.isRecipesLoading = true
    }
    
    private func handleRefreshData() {
        viewModel.currentPage = 0
        viewModel.recipesModels = []
        viewModel.isRecipesLoading = true
    }
    
    private func onLastListTiemElementAppear() {
        print(viewModel.currentPage)
        if (viewModel.totalPages > viewModel.currentPage) {
            fetchRecipes(showLoadingState: false)
            viewModel.currentPage = viewModel.currentPage + 1
        }
    }
    
    private func fetchRecipes(showLoadingState: Bool = true) {
        if showLoadingState {
            viewModel.isRecipesLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            //TODO: replace with real data
            viewModel.recipesModels.append(contentsOf: getNewRicipeMockData())
            viewModel.isRecipesLoading = false
        }
    }
}

#Preview {
    SearchRecipesScreen(
        viewModel: SearchRecipesScreenViewModel(recipesModels: [])
    )
}
