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
            ScrollViewReader { scrollView in
                ScrollView(.vertical) {
                    RecipeCardList(
                        recipeModels: $viewModel.recipesModels,
                        cardViewType: $viewModel.cardViewType,
                        isLoading: $viewModel.isRecipesLoading,
                        onScrollTargetAppear: onScrollTargetAppear
                    )
                    .padding(.vertical, 20)
                    
                    // Navigation link for transitioning to the search results screen
                    NavigationLink(
                        destination: SearchRecipesScreen(
                            viewModel: viewModel.getNewInstanceForNewSearchRequest()
                        ),
                        isActive: $isNavigateToNewSearchPage
                    ) { EmptyView() }
                }
                .onChange(of: viewModel.scrollToTop) {
                    withAnimation {
                        scrollView.scrollTo(1, anchor: .top)
                    }
                }
            }
            .scrollDisabled(viewModel.isRecipesLoading)
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
            
            // error alert
            .alert("An error has occurred", isPresented: $viewModel.isShowingErrorAlert) {
            } message: {
                Text("Сheck your internet connection or try again later")
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
        viewModel.updateSortBy(to: value)
    }

    private func handleFiltersAppllyButtonClick() {
        viewModel.applyFilters()
    }

    private func handleRefreshData() {
        viewModel.refreshData()
    }

    private func onScrollTargetAppear() {
        viewModel.fetchRecipes()
    }
}

#Preview {
    SearchRecipesScreen(
        viewModel: SearchRecipesScreenViewModel(recipesModels: [])
    )
}
