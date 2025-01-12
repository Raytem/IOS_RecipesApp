//
//  MainView.swift
//  RecipeBook
//
//  Created by Daniil on 5.01.25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var navigateToSearchScreen = false
    
    var body: some View {
        NavigationStack {
               VStack {
                   Text("Main page")
                       .foregroundStyle(Color(.label))
                   
                   Button(action: {
                       navigateToSearchScreen = true
                   }) {
                       Text("To Search page")
                   }
                   .buttonStyle(.bordered)
                   .buttonBorderShape(.capsule)
                   .tint(Color(UIColor.primary50))
               }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .navigationDestination(isPresented: $navigateToSearchScreen) {
                    SearchRecipesScreen(
                        viewModel: SearchRecipesScreenViewModel(recipesModels: [])
                    )
               }
               .background(Color(uiColor: .backgroundMain))
        }
        .accentColor(.toolbarItemAccent)
    }
}

#Preview {
    MainView()
}
