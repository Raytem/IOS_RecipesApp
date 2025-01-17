//
//  NavBarView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI

struct NavBar: View {
    @EnvironmentObject var tabBarSettings: TabBarSettings
    @Binding public var selectedTab: NavBarTab
    
    @State private var navBarTabsModels: [NavBarTabModel] = [
        .init(tab: .main, imageName: "house"),
        .init(tab: .savedRecipes, imageName: "bookmark")
    ]
      
    var body: some View {
            HStack(spacing: 0) {
                ForEach($navBarTabsModels, id: \.tab) { $tabModel in
                    Tab(tabModel: tabModel, selectedTab: $selectedTab)
                        .overlay {
                            if tabModel.tab == .savedRecipes {
                                SavedRecipesTabBadge()
                                    .offset(x: 12, y: -12)
                            }
                        }
                }
            }
            .background(
                Color(.backgroundLayer1)
                    .ignoresSafeArea(edges: [.bottom])
                    .shadow(
                        color: tabBarSettings.isShadowShowing
                            ? Color(.shadow)
                            : Color(.clear),
                        radius: 4,
                        y: -4
                    )
            )
        }
}

#Preview {
    NavBar(
        selectedTab: .constant(.main)
    )
    .environmentObject(TabBarSettings())
    .modelContainer(for: SavedRecipeModel.self, inMemory: true)
}
