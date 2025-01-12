//
//  ContentView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @State public var selectedTab: NavBarTab = .main
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                SearchRecipesScreen(
                    viewModel: SearchRecipesScreenViewModel(
                        recipesModels: []
                    )
                )
                    .setUpNavigationTab(.main)
                SavedRecipesView()
                    .setUpNavigationTab(.savedRecipes)
                SettingsView()
                    .setUpNavigationTab(.settings)
            }
            
            NavBarView(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ContentView()
}

extension View {
    func setUpNavigationTab(_ tab: NavBarTab) -> some View {
        self
            .tag(tab)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .toolbar(.hidden, for: .tabBar)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
