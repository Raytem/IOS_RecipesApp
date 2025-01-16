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
    
    var selectButtonText: LocalizedStringKey {
        viewModel.isEditModeEnabled ? "Cancel" : "Select"
    }
    
    var selectAllButtonText: LocalizedStringKey {
        viewModel.savedRecipes.count == viewModel.selectedRecipes.count
        ? "Reset"
        : "Select All"
    }
    
    var removeButtonText: LocalizedStringKey {
        if (
            viewModel.isEditModeEnabled
            && viewModel.selectedRecipes.count != 0
        ) {
            return "Remove: \(viewModel.selectedRecipes.count)"
        } else {
            return "Remove"
        }
    }
    
    var filteredRecipes: [SavedRecipeModel] {
        if !viewModel.query.isEmpty {
            return viewModel.savedRecipes.filter {
                $0.title.lowercased().contains(viewModel.query.lowercased())
            }
        }
        return viewModel.savedRecipes
    }
    
    var body: some View {
        NavigationStack {
                ZStack(alignment: .bottom) {
                    List {
                        ForEach(filteredRecipes, id: \.id) { recipe in
                            HStack(spacing: 10) {
                                if viewModel.isEditModeEnabled {
                                    HStack {
                                        if (isItemSelected(item: recipe)) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(.primary50)
                                        } else {
                                            Image(systemName: "circle")
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                    .font(.system(size: 20))
                                }
                            
                                SavedRecipeCard(
                                    savedRecipeModel: recipe,
                                    isNavigationLinkEnabled: viewModel.isEditModeEnabled
                                        ? .constant(false)
                                        : .constant(true)
                                )
                            }
                            .overlay {
                                if viewModel.isEditModeEnabled {
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .foregroundColor(.clear) // Убедитесь, что он визуально пустой
                                        .contentShape(Rectangle()) // Задаем область для жестов
                                        .onTapGesture {
                                            print("Overlay tapped")
                                            handleSelectItem(item: recipe)
                                        }
                                }
                            }
                                .listRowInsets(.init())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color(.backgroundMain))
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        handleRemoveSingleButtonClick(recipe)
                                    }) {
                                        Label("Remove", systemImage: "bookmark.slash")
                                    }
                                    .tint(Color(.secondary60))
                                }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                    .listRowSpacing(20)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                    .safeAreaPadding(.bottom, 80)
                    
                    FloatingActionBar(
                        position: .bottom
                    ) {
                        CustomButton(
                            title: removeButtonText,
                            color: .secondary,
                            startIcon: "bookmark.slash",
                            fullWidth: true,
                            disabled: viewModel.selectedRecipes.count == 0,
                            action: handleRemoveSelectedButtonClick
                        )
                    }
                    .opacity(viewModel.isEditModeEnabled ? 1 : 0)
                    .padding(.bottom, viewModel.isEditModeEnabled ? 0 : -100)
            }
            .background(.backgroundMain)
            
            .searchable(text: $viewModel.query)
            
            .toolbar {
                if (viewModel.isEditModeEnabled) {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: handleSelectAllButtonClick) {
                            Text(selectAllButtonText)
                        }
                    }
                }
                if (!viewModel.savedRecipes.isEmpty) {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: handleSelectButtonClick) {
                            Text(selectButtonText)
                        }
                    }
                }
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
    
    func handleSelectItem(item: SavedRecipeModel) {
        if (viewModel.selectedRecipes.contains(item)) {
            viewModel.selectedRecipes.remove(item)
        } else {
            viewModel.selectedRecipes.insert(item)
        }
    }
    
    func isItemSelected(item: SavedRecipeModel) -> Bool {
        viewModel.selectedRecipes.contains(item)
    }
    
    func handleSelectAllButtonClick() {
        if viewModel.selectedRecipes.count == viewModel.savedRecipes.count {
            viewModel.selectedRecipes = Set()
        } else {
            viewModel.selectedRecipes = Set(viewModel.savedRecipes)
        }
    }
    
    func handleSelectButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            viewModel.isEditModeEnabled.toggle()
        }
    }
    
    func handleRemoveSingleButtonClick(_ item: SavedRecipeModel) {
        withAnimation(.spring(duration: 0.2)) {
            viewModel.savedRecipes.removeAll(where: { $0 == item})
            if viewModel.isEditModeEnabled && viewModel.savedRecipes.count == 0 {
                viewModel.isEditModeEnabled = false
            }
        }
    }
    
    func handleRemoveSelectedButtonClick() {
        withAnimation(.spring(duration: 0.2)) {
            viewModel.savedRecipes.removeAll { savedRecipe in
                viewModel.selectedRecipes.contains(savedRecipe)
            }
            viewModel.selectedRecipes.removeAll()
            viewModel.isEditModeEnabled = false
        }
    }
}

#Preview {
    SavedRecipesScreen(
        viewModel: SavedRecipesViewModel()
    )
    .environmentObject(TabBarSettings())
}
