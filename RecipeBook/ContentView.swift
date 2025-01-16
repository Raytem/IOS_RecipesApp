//
//  ContentView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @State var selectedTab: NavBarTab = .main
    @StateObject var tabBarSettings = TabBarSettings()
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                SearchRecipesScreen(
                    viewModel: SearchRecipesScreenViewModel(
                        recipesModels: []
                    )
                )
                    .setUpNavigationTab(.main)
                SavedRecipesScreen(
                    viewModel: SavedRecipesViewModel()
                )
                    .setUpNavigationTab(.savedRecipes)
                SettingsView()
                    .setUpNavigationTab(.settings)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            NavBarView(selectedTab: $selectedTab)
        }
        .environmentObject(tabBarSettings)
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
